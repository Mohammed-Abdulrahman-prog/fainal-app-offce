
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Services {
  static String URLServer = "http://192.168.43.56:8080/project_Library_api/backendLibrary.php";
  static String UrlImages = "http://192.168.43.56:8080/project_Library_api/uploads/";

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedFile;
  String message ='';
  
  // // اختيار صورة
  // Future<void> pickFile() async {
  //   final picked = await _picker.pickImage(source: ImageSource.gallery);
  //   XFile? _selectedFile;
  //   if (picked != null) {
  //     setState(() {
  //       _selectedFile = picked;
  //     });
  //     print("File path: ${picked.path}");
  //   }
  // }

}