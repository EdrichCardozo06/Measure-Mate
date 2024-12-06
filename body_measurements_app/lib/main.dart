// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Body Measurements',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   File? selectedFile;
//   final TextEditingController heightController = TextEditingController();
//   Map<String, String>? results;

//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       setState(() {
//         selectedFile = File(result.files.single.path!);
//       });
//     }
//   }
// //
//   Future<void> sendRequest() async {
//   final messenger = ScaffoldMessenger.of(context); // Capture the context here
//   if (selectedFile == null || heightController.text.isEmpty) {
//     messenger.showSnackBar(
//       const SnackBar(content: Text('Please select a file and enter height.')),
//     );
//     return;
//   }

//   try {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('http://127.0.0.1:5000/process'),
//     );
//     request.fields['height'] = heightController.text;
//     request.files.add(await http.MultipartFile.fromPath('image', selectedFile!.path));

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       var responseData = await response.stream.bytesToString();
//       setState(() {
//         results = Map<String, String>.from(jsonDecode(responseData)['results']);
//       });
//     } else {
//       messenger.showSnackBar(
//         const SnackBar(content: Text('Failed to process the image.')),
//       );
//     }
//   } catch (e) {
//     // Network related errors (like SocketException)
//     String errorMessage = 'An error occurred. Please check your internet connection and try again.';
//     if (e is SocketException) {
//       errorMessage = 'No route to host. Please check if the server is running.';
//     }
//     // Show the error message in a SnackBar
//     messenger.showSnackBar(
//       SnackBar(content: Text(errorMessage)),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Body Measurements')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextButton(
//               onPressed: pickFile,
//               child: Text(selectedFile == null ? 'Select Image' : 'Change Image'),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: heightController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Enter Height (inches)'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: sendRequest,
//               child: const Text('Submit'),
//             ),
//             const SizedBox(height: 24),
//             results != null
//                 ? Expanded(
//                     child: ListView(
//                       children: results!.entries
//                           .map((entry) => ListTile(
//                                 title: Text(entry.key),
//                                 subtitle: Text(entry.value),
//                               ))
//                           .toList(),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//------------------------------------------------------------------------------------------------
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Body Measurements',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   File? _image;
//   final TextEditingController _heightController = TextEditingController();
//   String? _resultMessage;

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//     }
//   }

//   Future<void> _submit() async {
//     if (_image == null || _heightController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select an image and enter height.')),
//       );
//       return;
//     }

//     try {
//       final uri = Uri.parse('http://192.168.0.136:5000/process');
//       final request = http.MultipartRequest('POST', uri)
//         ..fields['height'] = _heightController.text
//         ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

//       final response = await request.send();

//       if (response.statusCode == 200) {
//         final responseData = await response.stream.bytesToString();
//         final decodedData = jsonDecode(responseData);
//         setState(() {
//           _resultMessage = decodedData['results'].toString();
//         });
//       } else {
//         setState(() {
//           _resultMessage = 'Error: ${response.reasonPhrase}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _resultMessage = 'Failed to connect to the server.';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Body Measurements')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text(_image == null ? 'Select Image' : 'Change Image'),
//             ),
//             if (_image != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Text('Selected: ${_image!.path.split('/').last}'),
//               ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _heightController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Enter Height (inches)'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submit,
//               child: const Text('Submit'),
//             ),
//             const SizedBox(height: 24),
//             if (_resultMessage != null)
//               Text(
//                 'Result: $_resultMessage',
//                 style: const TextStyle(color: Colors.green, fontSize: 16),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//-------------------------------------------------------------------------------------------------------------------
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Measurements',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final TextEditingController _heightController = TextEditingController();
  String? _resultMessage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _submit() async {
    if (_image == null || _heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image and enter height.')),
      );
      return;
    }

    try {
      final uri = Uri.parse('http://192.168.0.136:5000/process'); // Update to match server's IP
      final request = http.MultipartRequest('POST', uri)
        ..fields['height'] = _heightController.text
        ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = jsonDecode(responseData);
        setState(() {
          _resultMessage = decodedData['results'].toString();
        });
      } else {
        final responseData = await response.stream.bytesToString();
        setState(() {
          _resultMessage = 'Error: ${jsonDecode(responseData)['error']}';
        });
      }
    } catch (e) {
      setState(() {
        _resultMessage = 'Failed to connect to the server. Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Body Measurements')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text(_image == null ? 'Select Image' : 'Change Image'),
            ),
            if (_image != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Selected: ${_image!.path.split('/').last}'),
              ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter Height (inches)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 24),
            if (_resultMessage != null)
              Text(
                'Result: $_resultMessage',
                style: const TextStyle(color: Colors.green, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
