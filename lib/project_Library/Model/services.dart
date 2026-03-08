

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

  // رفع الصورة
  Future<String> uploadFile(int userId) async {
    if (_selectedFile == null) {
      message = "لم يتم اختيار ملف";
      print("لم يتم اختيار ملف");
      return message;
    }
    try {
      var uri = Uri.parse("http://192.168.43.56:8080/project_Library_api/backendLibrary.php");
      var request = http.MultipartRequest("POST", uri);

      request.fields['action'] = "uploadFile";
      String userid = userId.toString();
      request.fields['USER_ID'] = userid;
      // print("إرسال USERID: ${userid.runtimeType}");
      request.files.add(await http.MultipartFile.fromPath("file", _selectedFile!.path,),);

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print("Server Response: ${responseData}");
      var jsonResponse = jsonDecode(responseData);

      if (jsonResponse["status"] == "success") {
        message = "تم رفع الصورة بنجاح"; 
        print("تم رفع الصورة بنجاح");
        return message;
      } else {
        message = "خطأ فشل رفع الصورة"; 
        print("خطأ فشل رفع الصورة: ${jsonResponse["message"]}");
        return message;
      }

    } catch (e) {
      print("JSON Error: $e");
    }
    
    return message;
  }
}