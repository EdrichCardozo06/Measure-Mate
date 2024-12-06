
# Human Body-Measurements

This project uses state-of-the-art system that leverages computer vision and 3D modeling techniques to extract precise human body measurements from a single image. The project combines OpenCV, TensorFlow, and OpenDR to process images, detect keypoints, and reconstruct 3D models, enabling measurements of the human body.

Built upon the Human Mesh Recovery (HMR) model, this solution serves as a powerful starting point for research and development in body measurement and 3D human modeling.


## 🚀 Features

1. Single Image Analysis: Perform measurements using a single human image.
2. 3D Model Reconstruction: Generate a 3D model overlayed on the input image for accurate validation.
3. Precise Measurements: Calculate dimensions of body parts like:

```bash
{
    1. Arm Length   2.  Waist Circumference
    3. Hip Width    4. Height   
    5. Belly        6. Chest
    7. Wrist        8. Neck
    9.Thigh        10. Shoulder width
    11. Ankle   
}
```

4. Customizable and Extensible: Easily adaptable for further research or other body measurement applications.
5. Compatibility: Verified with TensorFlow 1.13.1 for consistent performance.




## 🛠️ Technologies Used
1. Programming Language: Python
2. Libraries and Frameworks:
- Flask

- OpenCV: For image processing and keypoint detection.

-  TensorFlow 1.13.1: For deep learning and HMR model integration.

-  OpenDR: For camera access and 3D rendering.

3. Machine Learning Model:
- Human Mesh Recovery (HMR): Pretrained model for 3D human pose and shape estimation.

4. App devolopment:
- Flutter 
- Android Studio (ladybug)
## ⚙️ Setup and Installation
1. Prerequisites :
- Install Anaconda for environment management.
- Ensure you have Python 3.6 - 3.7 installed.

2. Clone the Repository

```bash
https://github.com/EdrichCardozo06/Body_Measurement_model.git
cd Body_Measurement_model
```
3. Create the Conda Environment
```bash
conda create -n body-measurement python=3.7
conda activate body-measurement   
``` 
4. Run the `demo.ipynb` file 

5. Download Models and Resources
- Place the pre-trained HMR models in the models/ directory.
- Download pre-trained model
Type the following command on the terminal to download pre-trained model,

`wget https://people.eecs.berkeley.edu/~kanazawa/cachedir/hmr/models.tar.gz && tar -xf models.tar.gz`
- Add keypoints.txt in the data/ folder for processing sample data.

6. after runnig all this step , Run the below command :

`python inference.py -i <path to Image1> -ht <height in inches>`


## 📊 Output

- Measurement Results: Precise body part dimensions displayed in the console.

## 🧩 How It Works
1. Keypoint Detection:
- Utilizes OpenCV to detect human keypoints from the input image.
- Reads keypoint data from keypoints.txt for processing.
2. 3D Model Reconstruction:
- Employs the HMR model for reconstructing a 3D human mesh.
- Aligns the mesh with the input image using camera parameters.
3. Measurement Calculation:
- Extracts specific measurements from the reconstructed 3D mesh.
Outputs results in inches for precision.


