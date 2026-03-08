// import 'package:flutter/material.dart';
// 

// import 'dart:convert';

// import 'package:pract_univr/OrderScreen.dart';
// import 'package:pract_univr/listviewlab3.dart';
// import 'package:pract_univr/products_page.dart';



// class Loginscreen extends StatefulWidget {
//   createState() => _Loginscreen();
// }

// class _Loginscreen extends State<Loginscreen> {
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
//   String result = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//           child: Column(
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           TextFormField(
//             controller: username,
//             decoration: InputDecoration(
//               label: Text("User name"),
//               hintText: "Enter user name",
//             ),
//           ),
//           TextFormField(
//             controller: password,
//             decoration: InputDecoration(
//               label: Text("password"),
//               hintText: "Enter password",
//             ),
//           ),

//           Text("$result"),
//           SizedBox(
//             height: 50,
//           ),
//           OutlinedButton(
//               onPressed: () async{
//                 print(username.text);
//                 print(password.text);
//                 var response = await login(username.text, password.text);
//                 print(response);

//                 if(response['status'] == 'success'){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Products()));
//                 }else{
//                   // print("no");
//                   setState(() {
//                     result = response['status'];
//                     username.clear();
//                     password.clear();
//                   });
//                 }
//               },
//               child: Text("Login"))
//         ],
//       )),
//     );
//   }
// }

// http://localhost:8080/project/backend.php      // هنا عملنا localhost:8080 لانه غيرنا بورت السيرفير 
// http://192.168.43.56:8080/project/backend.php // عنوان الواي فاي
// http://127.0.0.1:8080/project/backend.php     // هنا إذا تشغل التطبيق على هاتف
// http://10.0.2.2:8080/project/backend.php     // هذا عندما يكون معك محاكي android


// login(String user, String pass) async{
//   String url = "http://192.168.43.181/project_api/backend.php";
//   var response = await http.post(
//     Uri.parse(url),
//     body: {
//       "action": "login",
//       "username": user,
//       "password": pass,
//     } 
//   );

//   dynamic data = jsonDecode(response.body);
//   // print(data);
//   return data;
// }

///////////////// لجلب البيانات باستخدام post
// Future  getData() async {
//   var url = Uri.parse("http://10.0.2.2:8080/project/backend.php");

//   var re2 = await http.post(url, body: {
//     "actions" : 'fetchData'
// });
//   var re3 = jsonDecode(re2.body);
//   print(re3);
// }

/////////////////  لجلب البيانات باستخدام get عبر الرابط لانه ليس في ال get جسم body
// Future  getData() async {
//   var url = Uri.parse("http://10.0.2.2:8080/project/backend.php?actions=fetchData");

//   var re2 = await http.get(url);
//   var re3 = jsonDecode(re2.body);
//   print(re3);
// }

///////////////////  هنا التحقق من تسجيل الدخول باستخدام get ولكن ضروري تكون معدل طريق استقبال البرمترات في Api باستخدام Get والا ما بيرضي
// Future  getData() async {
//   var url = Uri.parse("http://10.0.2.2:8080/project/backend.php?actions=login&USERNAME=moh &PASSWORD=123");

//   var re2 = await http.get(url);
//   var re3 = jsonDecode(re2.body);
//   print(re3);
// }

// مكان تعديل api لاستقبال البرمترات 
// Handling API requests
// if ($_SERVER['REQUEST_METHOD'] === 'GET') { // اما هنا بتغيره عند استخدام طريقة الطلب var re2 = await http.get(url);
//     $action = $_GET['actions'] ?? '';       // هنا طريق ارسال برمترات actions ضروري تغيره مع السابع عند تغيير الطريقة

//     switch ($action) {
//         case 'register':
//             $username = $_POST['USERNAME'] ?? '';
//             $password = $_POST['PASSWORD'] ?? '';
//             echo register($username, $password);
//             break;

//         case 'login':
//             $username = $_GET['USERNAME'] ?? ''; // هنا تعدل طريق استقبال البرمترات الخاصة بتسجيل الدخول
//             $password = $_GET['PASSWORD'] ?? ''; // هنا تعدل طريق استقبال البرمترات الخاصة بتسجيل الدخول 
//             echo login($username, $password);
//             break;

//         case 'fetchData':
//             echo fetchData();
//             break;

//         default:
//             echo json_encode(["status" => "error", "message" => "Invalid action."]);
//             break;
//     }
// } else {
//     echo json_encode(["status" => "error", "message" => "Only POST requests are allowed."]);
// }
