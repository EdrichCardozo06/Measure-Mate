# from flask import Flask, request, jsonify
# import subprocess
# import os
# import re

# app = Flask(__name__)
# UPLOAD_FOLDER = 'uploads'
# os.makedirs(UPLOAD_FOLDER, exist_ok=True)
# @app.route('/')
# def index():
#     return 'Welcome to the Flask app!'

# import sys
# print(f"Using Python executable: {sys.executable}")
# print(f"Python version: {sys.version}")

# @app.route('/process', methods=['POST'])
# def process_file():
#     if 'image' not in request.files or not request.form.get('height'):
#         return jsonify({'error': 'Missing image or height input.'}), 400

#     # Save uploaded file
#     file = request.files['image']
#     height = request.form['height']
#     input_path = os.path.join(UPLOAD_FOLDER, file.filename)
#     file.save(input_path)

#     # Run your command and capture output
#     command = [
#         'python', 'inference.py',
#         '-i', input_path,
#         '-ht', height
#     ]
#     process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
#     stdout, stderr = process.communicate()

#     # Extract results from stdout
#     output_pattern = r"(height|waist|belly|chest|wrist|neck|arm length|thigh|shoulder width|hips|ankle):\s([\d.]+)"
#     results = re.findall(output_pattern, stdout)
#     results_dict = {key: value for key, value in results}

#     if results_dict:
#         return jsonify({'results': results_dict})
#     else:
#         return jsonify({'error': f'Processing completed, but no measurements were found. Errors: {stderr}'}), 500

# if __name__ == '__main__':
#     app.run( host='0.0.0.0',port=5000, debug=True)
#------------------------------------------------------------------------------------------------------------------------------------------
# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import subprocess
# import os
# import re

# app = Flask(__name__)
# CORS(app)  # Enable CORS for all routes

# UPLOAD_FOLDER = 'uploads'
# os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# @app.route('/')
# def index():
#     return 'Welcome to the Flask app!'

# import sys
# print(f"Using Python executable: {sys.executable}")
# print(f"Python version: {sys.version}")

# @app.route('/process', methods=['POST'])
# def process_file():
#     if 'image' not in request.files or not request.form.get('height'):
#         return jsonify({'error': 'Missing image or height input.'}), 400

#     # Save uploaded file
#     file = request.files['image']
#     height = request.form['height']
#     input_path = os.path.abspath(os.path.join(UPLOAD_FOLDER, file.filename))
#     file.save(input_path)

#     # Run your command and capture output
#     command = [
#         'python', 'inference.py',
#         '-i', input_path,
#         '-ht', height
#     ]
#     process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
#     stdout, stderr = process.communicate()

#     if process.returncode != 0:
#         return jsonify({'error': f'Error running command: {stderr}'}), 500

#     # Extract results from stdout
#     output_pattern = r"(height|waist|belly|chest|wrist|neck|arm length|thigh|shoulder width|hips|ankle):\s([\d.]+)"
#     results = re.findall(output_pattern, stdout)
#     results_dict = {key: value for key, value in results}

#     if results_dict:
#         return jsonify({'results': results_dict})
#     else:
#         return jsonify({'error': f'Processing completed, but no measurements were found. Errors: {stderr}'}), 500

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5000, debug=True)##
from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess
import os
import re

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

UPLOAD_FOLDER = os.path.abspath('uploads')
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route('/')
def index():
    return 'Welcome to the Flask app!'

import sys
print(f"Using Python executable: {sys.executable}")
print(f"Python version: {sys.version}")

@app.route('/process', methods=['POST'])
def process_file():
    if 'image' not in request.files or not request.form.get('height'):
        return jsonify({'error': 'Missing image or height input.'}), 400

    # Save uploaded file
    file = request.files['image']
    height = request.form['height']
    input_path = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(input_path)

    # Run inference script
    command = [
        'python', 'inference.py',
        '-i', input_path,
        '-ht', height
    ]
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    stdout, stderr = process.communicate()

    if process.returncode != 0:
        return jsonify({'error': f'Command execution failed: {stderr.strip()}'}), 500

    # Parse output
    output_pattern = r"(height|waist|belly|chest|wrist|neck|arm length|thigh|shoulder width|hips|ankle):\s([\d.]+)"
    results = re.findall(output_pattern, stdout)
    results_dict = {key: value for key, value in results}

    if results_dict:
        return jsonify({'results': results_dict})
    else:
        return jsonify({'error': f'No measurements found. Debugging output: {stdout.strip()}'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
