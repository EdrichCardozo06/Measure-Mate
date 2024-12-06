
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




