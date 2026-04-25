import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Services {
  static final String URLServer = "http://172.20.51.6:8080/project_Library_api/backendLibrary.php";
  static final String UrlImages = "http://172.20.51.6:8080/project_Library_api/uploads/";

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedFile;
  String message ='';
  
  static Login(String user, String pass) async{
    String url = URLServer;
    try{
      dynamic response = await http.post(
        Uri.parse(url),
        body: {
          "action": "login",
          "USERNAME": user,
          "PASSWORD": pass,
        } 
      );
      response = jsonDecode(response.body);
      // print("response id: ${response['data']['id']}");
      // print(response['data']['id'].runtimeType); // لعرض نوع المتغير
      // print(response);
      return response;
    } catch(e){
      print("Error in connect: $e");
    }
  }

  static CreateAccou(String user, String pass) async{
    String url = URLServer;
    try{
      dynamic response = await http.post(
        Uri.parse(url),
        body: {
          "action": "register",
          "USERNAME": user,
          "PASSWORD": pass,
        } 
      );
      response = jsonDecode(response.body);
      // print(response);
      return response;
    } catch(e){
      print("Error in connect: $e");
    }
  }

}