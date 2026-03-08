import 'dart:convert';
import 'package:fainal_app_offce/project_Library/Model/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class FileUploadPage extends StatefulWidget {
  int userId;
  FileUploadPage({required this.userId});

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}


class _FileUploadPageState extends State<FileUploadPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedFile;
  String message ='';

  // اختيار صورة
  Future<void> pickFile() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedFile = picked;
      });
      print("File path: ${picked.path}");
    }
  }

  // رفع الصورة
  Future<void> uploadFile(int userId) async {
    if (_selectedFile == null) {
      message = "لم يتم اختيار ملف";
      print("لم يتم اختيار ملف");
      return;
    }
    try {
      var uri = Uri.parse(Services.URLServer);
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
        setState(() { message = "تم رفع الصورة بنجاح"; });
        print("تم رفع الصورة بنجاح");
      } else {
        setState(() { message = "خطأ فشل رفع الصورة"; });
        print("خطأ فشل رفع الصورة: ${jsonResponse["message"]}");
      }

    } catch (e) {
      print("JSON Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('رفع الصور', 
      style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color(0xFF4B0082),
      iconTheme: IconThemeData(color: Colors.white, ),
      
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedFile != null) Text('تم اختيار: ${_selectedFile!.name}'),
            ElevatedButton(
              onPressed: pickFile,
              child: Text('اختيار صورة', style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                uploadFile(widget.userId);
                setState(() {
                  message;
                });
              },
              child: Text('رفع الصورة', style: TextStyle(fontSize: 20),),
            ),

            SizedBox(height: 10,),
            
            Text("$message"),
          ],
        ),
      ),
    );
  }
}