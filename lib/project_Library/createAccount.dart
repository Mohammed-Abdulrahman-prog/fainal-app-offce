
import 'package:fainal_app_offce/project_Library/Model/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String result = '';
  bool HiddenPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("انشاء حساب",
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4B0082),
        iconTheme: IconThemeData(color: Colors.white, ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        label: Text("اسم الستخدم"),
                        hintText: "ادخل اسم المستخدم",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFF4B0082))
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
                          borderSide: BorderSide(color: Color(0xFF4B0082))
                        ),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() { HiddenPass = !HiddenPass; });
                        }, icon: Icon(
                          HiddenPass? Icons.visibility_off : Icons.visibility))
                      ),
                    ),
                
                    Text("$result", style: TextStyle(color: const Color.fromARGB(255, 155, 56, 49)),),
                    SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                        onPressed: () async{
                          try{
                            var response = await CreateAccou(username.text, password.text);
                            print(response);
                
                            if(username.text.isEmpty || password.text.isEmpty){
                              setState(() {
                                result = "الرجاء ادخال قيمة في الحقل";
                              });
                            }else if(response['status'] == 'success'){
                              setState(() {
                                result = "تم انشاء الحساب";
                                username.clear();
                                password.clear();
                              });
                            } else if(response['status'] == 'error'){
                              setState(() {
                                result ="لم يتم انشاء حساب يوجد مستخدم بهذا الاسم";
                                username.clear();
                                password.clear();
                              });
                            }  
                
                          }catch(e){
                            setState(() {
                              result = "$e";
                            });
                          }
                        },
                        child: Text("انشاء")),

                  ],
            )),
          ),
        ),
      ),
    );
  }
}

CreateAccou(String user, String pass) async{
  String url = Services.URLServer;
  var response = await http.post(
    Uri.parse(url),
    body: {
      "action": "register",
      "USERNAME": user,
      "PASSWORD": pass,
    } 
  );

  dynamic data = jsonDecode(response.body);
  print(data);
  return data;
}