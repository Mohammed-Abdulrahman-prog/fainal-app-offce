
// import 'dart:nativewrappers/_internal/vm/bin/vmservice_io.dart';

import 'package:fainal_app_offce/project_Library/Home.dart';
import 'package:fainal_app_offce/project_Library/Model/services.dart';
import 'package:fainal_app_offce/project_Library/ShowImage.dart';
import 'package:fainal_app_offce/project_Library/createAccount.dart';
import 'package:fainal_app_offce/project_Library/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loginscreen extends StatefulWidget {
  createState() => _Loginscreen();
}

class _Loginscreen extends State<Loginscreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String result = '';
  bool HiddenPass = true;
  late int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
          "تسجيل الدخول",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4B0082),
      ), 
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "أهلاً بك في التطبيق",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B0082), // الأزرق الداكن
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        label: Text("اسم الستخدم"),
                        hintText: "ادخل اسم المستخدم",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xFF4B0082)), // الأزرق الداكن
                      ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: password,
                      obscureText: HiddenPass,
                      decoration: InputDecoration(
                        label: Text("كلمة المرور"),
                        hintText: "ادخل كلمة المرور",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xFF4B0082)), // الأزرق الداكن
                      ),
                        suffixIcon: IconButton(
                        icon: Icon(
                          HiddenPass ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            HiddenPass = !HiddenPass;
                          });
                        },
                      ),
                      ),
                    ),
                        
                    Text("$result", style: TextStyle(color: const Color.fromARGB(255, 155, 56, 49)),),
                    SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                        onPressed: () async{
                          try{
                            var response = await Services.Login(username.text, password.text);
                            print(response);
                        
                            if(username.text.isEmpty || password.text.isEmpty){
                              setState(() {
                                result = "الرجاء ادخال قيمة في الحقل";
                              });
                            }else if(response['status'] == 'success'){
                              var resp_userid = await Services.Login(username.text, password.text);
                              setState(() {
                                userId = int.parse(resp_userid['data']['id']);
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Home(userId: userId,)));
                            }else if(response['status'] == 'error'){
                              setState(() {
                                result = "خطا في اسم المستخدم او كلمة المرور";
                              });
                            }
                        
                          }catch(e){
                            result = "$e";
                          }
                        },
                        child: Text("تسجيل الدخول", style: TextStyle(fontSize: 15),)),
                        SizedBox(),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                          ),
                          onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));
                        }, child: Text("انشاء حساب")),
                        
                  ],
                        ),
              )),
        ),
      ),
    );
  }
}

// Login(String user, String pass) async{
//   String url = Services.URLServer;
//   var response = await http.post(
//     Uri.parse(url),
//     body: {
//       "action": "login",
//       "USERNAME": user,
//       "PASSWORD": pass,
//     } 
//   );

  // dynamic data = jsonDecode(response.body);
  // print("data id: ${data['data']['id']}");
  // print(data['data']['id'].runtimeType); // لعرض نوع المتغير
  // // print(data);
  // return data;
  // }

