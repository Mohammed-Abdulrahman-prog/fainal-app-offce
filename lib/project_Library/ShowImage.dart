import 'dart:convert';
import 'package:fainal_app_offce/project_Library/fullScreenImage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowImagesPage extends StatefulWidget {
  int userId;
  ShowImagesPage({required this.userId});

  @override
  _ShowImagesPageState createState() => _ShowImagesPageState();
}

class _ShowImagesPageState extends State<ShowImagesPage> {

  List files = [];
  String URl = "http://192.168.43.56:8080/project_Library_api/backendLibrary.php";
  var imageUrl = "http://192.168.43.56:8080/project_Library_api/uploads/";
  @override
  void initState() {
    super.initState();
    fetchFiles(widget.userId);
  }

  Future<void> fetchFiles(int userid) async {
    var uri = Uri.parse(URl);
    String useridd = userid.toString();
    var response = await http.post(uri, 
    body: {
      "action":"getFiles",
      "USER_ID": useridd,
      });
    print("Response: ${response.body} ");
    var data = jsonDecode(response.body);
    print("Data: ${data} ");
    if(data['status']=="success"){
      setState(() {
        files = data['files'];
      });
    } else {
      print(data['message']);
    }
  }

  Future<void> deleteFile(int id) async {
    try{
      var uri = Uri.parse(URl);
      var response = await http.post(uri, body: {"action":"deleteFile", "id":id.toString()});
      var data = jsonDecode(response.body);

      if(data['status']=="success"){
        print("تم حذف الصورة");
        fetchFiles(widget.userId); // إعادة تحميل الصور
      } else {
        print(data['message']);
      }
    } catch(e){
      print("Error in deleteFile: ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("عرض الصور", 
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4B0082),
        iconTheme: IconThemeData(color: Colors.white, ), // لون سهم الرجوع
      ),

      body: files.isEmpty ? Center(child: Text("لا توجد صور")) 
              : ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context,index){
                    var file = files[index];
                    var imageUrl = "http://192.168.43.56:8080/project_Library_api/uploads/${file['name']}";
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          // الانتقال لصفحة عرض الصورة
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImagePage(
                                imageUrl: imageUrl,
                                fileName: file['name'],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                          title: Text(file['name']),
                          subtitle: Text("الحجم: ${file['size']} بايت "),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              try{
                                deleteFile(int.parse(file['id'].toString()));
                              }catch(e){
                                print("Error id delete : $e");
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}