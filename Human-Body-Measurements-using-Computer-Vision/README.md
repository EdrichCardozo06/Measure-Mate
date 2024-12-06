
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
- Already Added keypoints.txt in the data/ folder for processing sample data.
- afte downloading the pre trained models verify them by checking id a deep_lab adn models folder is created .
  
6. after runnig all this step , Run the below command :

`python inference.py -i <path to Image1> -ht <height in inches>`


## 📊 Output
![Screenshot 2024-12-06 113220](https://github.com/user-attachments/assets/ab2e597f-987d-41d4-9ae1-b7a4da2387b6)

-----------------------------------------------------------------------------------------------------------------------

## To host using flask :

1. Run the `app.py` after activation of the conda enviroment:

    ```bash
   conda activate conda_env_name
   python app.py
    ```
2. if you get the error of modules not being installed type :

     ```bash
   where python  //to find all python.exe executables
   c:\path\to\conda\env\python app.py
    ```
Running app.py:(use the second server address)
![Screenshot 2024-12-06 110501](https://github.com/user-attachments/assets/d004e5d0-091f-4a90-8053-80f45d542f43)

If you get errors follow step 2:
- here is how it should look :
![Screenshot 2024-12-06 110819](https://github.com/user-attachments/assets/b1810d00-3e2b-4eda-a2d8-44c25c12aec6)



