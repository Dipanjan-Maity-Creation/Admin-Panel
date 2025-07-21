import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as io; // Import for desktop/mobile
import 'package:flutter/foundation.dart'; // Import for kIsWeb

// Import dart:html only for Web
// Prevents errors in desktop/mobile builds
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: BannersScreen()));
}

class BannersScreen extends StatefulWidget {
  @override
  _BannerUploadScreenState createState() => _BannerUploadScreenState();
}

class _BannerUploadScreenState extends State<BannersScreen> {
  io.File? _desktopImageFile; // For desktop
  html.File? _webImageFile; // For web
  String? _uploadedFileURL;
  String? _webImageUrl; // To hold the URL for the web image

  Future<void> _uploadBanner() async {
    if (_desktopImageFile == null && _webImageFile == null) return;

    final storageRef = FirebaseStorage.instance.ref();
    final bannerRef = storageRef.child("banners/${DateTime.now().millisecondsSinceEpoch}.jpg");

    try {
      if (!kIsWeb) {
        // Upload for Desktop/Mobile
        await bannerRef.putFile(_desktopImageFile!);
      } else {
        // Upload for Web
        final reader = html.FileReader();
        reader.readAsArrayBuffer(_webImageFile!);
        await reader.onLoadEnd.first; // Ensure file is fully read before proceeding

        final Uint8List bytes = reader.result as Uint8List;
        await bannerRef.putData(bytes);
      }

      String downloadURL = await bannerRef.getDownloadURL();
      setState(() {
        _uploadedFileURL = downloadURL;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload Successful!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload Failed: $e")),
      );
    }
  }



  Future<void> _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true, // Important for web
    );

    if (result != null && result.files.isNotEmpty) {
      if (kIsWeb) {
        // Handle Web File
        Uint8List fileBytes = result.files.single.bytes!;
        String fileName = result.files.single.name;

        _webImageFile = html.File([fileBytes], fileName);
        final reader = html.FileReader();
        reader.readAsDataUrl(_webImageFile!);

        reader.onLoadEnd.listen((e) {
          setState(() {
            _webImageUrl = reader.result.toString();
            _desktopImageFile = null; // Clear desktop file
          });
        });
      } else {
        // Handle Desktop/Mobile File
        setState(() {
          _desktopImageFile = io.File(result.files.single.path!);
          _webImageFile = null; // Clear web file
          _webImageUrl = null;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Banner Image")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display image based on platform
            if (_desktopImageFile != null)
              Image.file(_desktopImageFile!, height: 200)
            else if (_webImageUrl != null)
              Image.network(_webImageUrl!, height: 200), // Display the web image

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text("Select Banner Image"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadBanner,
              child: Text("Upload Banner"),
            ),
            SizedBox(height: 20),
            if (_uploadedFileURL != null)
              Text("Uploaded Image URL: $_uploadedFileURL"),
          ],
        ),
      ),
    );
  }
}