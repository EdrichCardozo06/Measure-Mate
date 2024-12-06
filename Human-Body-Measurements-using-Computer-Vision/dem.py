import os
import cv2
import numpy as np
from PIL import Image
from demo import main
import tensorflow as tf
import tarfile
from six.moves import urllib


class DeepLabModel(object):
    INPUT_TENSOR_NAME = 'ImageTensor:0'
    OUTPUT_TENSOR_NAME = 'SemanticPredictions:0'
    INPUT_SIZE = 513
    FROZEN_GRAPH_NAME = 'frozen_inference_graph'

    def __init__(self, tarball_path):
        self.graph = tf.Graph()
        graph_def = None
        tar_file = tarfile.open(tarball_path)
        for tar_info in tar_file.getmembers():
            if self.FROZEN_GRAPH_NAME in os.path.basename(tar_info.name):
                file_handle = tar_file.extractfile(tar_info)
                graph_def = tf.GraphDef.FromString(file_handle.read())
                break
        tar_file.close()

        if graph_def is None:
            raise RuntimeError('Cannot find inference graph in tar archive.')

        with self.graph.as_default():
            tf.import_graph_def(graph_def, name='')

        self.sess = tf.Session(graph=self.graph)

    def run(self, image):
        width, height = image.size
        resize_ratio = 1.0 * self.INPUT_SIZE / max(width, height)
        target_size = (int(resize_ratio * width), int(resize_ratio * height))
        resized_image = image.convert('RGB').resize(target_size, Image.ANTIALIAS)
        batch_seg_map = self.sess.run(
            self.OUTPUT_TENSOR_NAME,
            feed_dict={self.INPUT_TENSOR_NAME: [np.asarray(resized_image)]}
        )
        seg_map = batch_seg_map[0]
        return resized_image, seg_map


def initialize_model():
    """Initialize and return the DeepLab model."""
    MODEL_NAME = 'xception_coco_voctrainval'
    _DOWNLOAD_URL_PREFIX = 'http://download.tensorflow.org/models/'
    _MODEL_URLS = {
        'xception_coco_voctrainval':
            'deeplabv3_pascal_trainval_2018_01_04.tar.gz',
    }
    _TARBALL_NAME = _MODEL_URLS[MODEL_NAME]

    model_dir = 'deeplab_model'
    os.makedirs(model_dir, exist_ok=True)
    download_path = os.path.join(model_dir, _TARBALL_NAME)
    if not os.path.exists(download_path):
        urllib.request.urlretrieve(_DOWNLOAD_URL_PREFIX + _MODEL_URLS[MODEL_NAME], download_path)

    return DeepLabModel(download_path)


def process_image(image_path, height, model):
    """Process an image using the DeepLab model."""
    image = Image.open(image_path)
    res_im, seg = model.run(image)

    seg = cv2.resize(seg.astype(np.uint8), image.size)
    mask_sel = (seg == 15).astype(np.float32)
    mask = 255 * mask_sel.astype(np.uint8)

    img = np.array(image)
    img = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)

    res = cv2.bitwise_and(img, img, mask=mask)
    bg_removed = res + (255 - cv2.cvtColor(mask, cv2.COLOR_GRAY2BGR))

    # Call the main function with the processed image
    main(bg_removed, height, None)
    return "Processing complete!"

    
if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description='Deeplab Segmentation')
    parser.add_argument('-i', '--input_dir', type=str, required=True, help='Directory to save the output results. (required)')
    parser.add_argument('-ht', '--height', type=int, required=True, help='Height of the person in inches. (required)')
    args = parser.parse_args()

    dir_name = args.input_dir

    # Load and process the image
    MODEL_NAME = 'xception_coco_voctrainval'
    _DOWNLOAD_URL_PREFIX = 'http://download.tensorflow.org/models/'
    _MODEL_URLS = {
        'xception_coco_voctrainval':
            'deeplabv3_pascal_trainval_2018_01_04.tar.gz',
    }
    _TARBALL_NAME = _MODEL_URLS[MODEL_NAME]

    model_dir = 'deeplab_model'
    os.makedirs(model_dir, exist_ok=True)
    download_path = os.path.join(model_dir, _TARBALL_NAME)
    if not os.path.exists(download_path):
        urllib.request.urlretrieve(_DOWNLOAD_URL_PREFIX + _MODEL_URLS[MODEL_NAME], download_path)

    model = DeepLabModel(download_path)
    print('Model loaded successfully!')

    image = Image.open(dir_name)
    process_image(image, args.height, model)
