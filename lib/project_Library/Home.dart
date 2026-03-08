
import 'dart:async';
import 'package:fainal_app_offce/project_Library/Model/services.dart';
import 'package:fainal_app_offce/project_Library/ShowImage.dart';
import 'package:fainal_app_offce/project_Library/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // مكتبة للتحويل من اجل jason


class Home extends StatefulWidget {
  final int userId;

  Home({required this.userId});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  List files = [];


  Future<void> fetchFiles(int userid) async {
    var uri = Uri.parse(Services.URLServer);
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

  @override
  void initState() {
    super.initState();
    try{
      fetchFiles(widget.userId);
      _pageController = PageController(initialPage: 0);

      // إعداد المؤقت لتحريك الصفحات تلقائيًا
      _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
        if (_currentPage < files.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });       
    }catch(e){
      print("error2: $e");
    }
  }

  @override
  void dispose() {
    try{
      _timer?.cancel(); // إيقاف المؤقت عند التخلص من الـ Widget
      
      _pageController.dispose();          
    }catch(e){
      print("error3: $e");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الصفحة الرئيسية",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF4B0082),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF4B0082),
                ),
                child: Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(left: 5, top: 5, bottom: 50, right: 180),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: Colors.white,
                    
                  ),
                  child: Center(
                    child: Text(
                      "user" ,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
            ),
            ListTile(
                leading: Icon(Icons.upload),
                title: Text("رفع الصور", style: TextStyle(fontSize: 20),),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FileUploadPage(userId: widget.userId,)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text("عرض الصور", style: TextStyle(fontSize: 20),),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ShowImagesPage(userId: widget.userId,)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("خروج", style: TextStyle(fontSize: 20),),
                onTap: () {
                  Navigator.of(context).pop(); // إغلاق  Drawer
                  SystemNavigator.pop(); // الخروج من التطبيق
                },
              ),
          ],
        ),
      ),
       body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: PageView.builder(
                controller: _pageController, // استخدم الـ PageController
                itemCount: files.length,
                itemBuilder: (context, index) {
                  try{
                    var file = files[index];
                    var imageUrl = "${Services.UrlImages}${file['name']}";
                  return Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover);
                  }catch(e){
                    print("error1: $e");
                  }
                },
              ),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// زر رفع الصور
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  icon: Icon(Icons.upload),
                  label: Text("رفع الصور", style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FileUploadPage(userId: widget.userId,),
                      ),
                    );
                  },
                ),

                SizedBox(width: 20),

                /// زر عرض الصور
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  icon: Icon(Icons.image),
                  label: Text("عرض الصور", style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowImagesPage(userId: widget.userId,),
                      ),
                    );
                  },
                ),
              ],
            ),
            
          ],
        ),
    );
  }
}

