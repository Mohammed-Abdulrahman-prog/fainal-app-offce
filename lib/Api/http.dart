
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // مكتبة للتحويل من اجل jason

// طريقة get 
class HttpApi extends StatefulWidget {
  const HttpApi({super.key});

  @override
  State<HttpApi> createState() => _HttpApiState();
}

class _HttpApiState extends State<HttpApi> {



 Future getPosts() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts?id=27&userId=3"); 

    var response = await http.get(url); 
    var responsebody = jsonDecode(response.body); 

    return responsebody; // 
  }

  addPosts() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    var response = await http.post(
      url, 
      body: { // لاضافة بيانات عبر post
      "title":'fohghfjddfdfhho',
      "body": 'bar',
      "userId": '1',
    },
    headers: { // لدعم الترميز باللغة العربية والانجيزية
      'Content-type': 'application/json; charset=UTF-8',
    }
    );

    var responsebody = jsonDecode(response.body);
    print(responsebody);    
    return responsebody;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dialog"),
      ),
      body: ListView(
        children: [
          ElevatedButton(onPressed: (){
            addPosts();
          }, child: Text("Add Posts")),
          FutureBuilder(
            future: getPosts(),
            initialData: [], // قيمة ابتائية بدل فارغة تحل محل CircularProgressIndicator
            builder: (context, snapshot){
              if(snapshot.hasData){ // تحقق عشان في حالة لم يتم تحمب البيانات
                return ListView.builder(
                    shrinkWrap: true, // هذي مع physics نعملها بسبب انه معنا listview داخل listview
                    physics: NeverScrollableScrollPhysics(), 
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i){
                      return Container(
                        color: Colors.white,
                        margin: EdgeInsets.all( 10),
                        child: Text("${snapshot.data[i]["title"]}"));
                      });
              }
              return Center(child: CircularProgressIndicator(),);
      })
        ],
      )
    );
  }
}


// // الطرية الثاني في  api 
// class HttpApi extends StatefulWidget {
//   const HttpApi({super.key});

//   @override
//   State<HttpApi> createState() => _HttpApiState();
// }

// class _HttpApiState extends State<HttpApi> {

// List posts =[]; // لكي نخزن داخلها البيانات

//  Future getPost() async {
//     // https://jsonplaceholder.typicode.com/posts?id=27&userId=3
//     var url = Uri.parse("https://jsonplaceholder.typicode.com/posts"); // رابط الموقع api الا بجلب منه البيانات

//     var response = await http.get(url); // لجلب بيانات المجودة في api ضروري هنا يكون في معالجة في حالة لم اقد اوصل لي موقع api
//     var responsebody = jsonDecode(response.body); // لفك ترميز البيانات 
//     posts.addAll(responsebody); 
//     print("Data......: $posts"); // 

//     return responsebody; // 
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("dialog"),
//       ),
//       body: FutureBuilder(
//         future: getPost(),
//         initialData: [], // قيمة ابتائية بدل فارغة تحل محل CircularProgressIndicator
//         builder: (context, snapshot){
//           if(snapshot.hasData){ // تحقق عشان في حالة لم يتم تحمب البيانات
//             return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (context, i){
//                   return Container(
//                     color: Colors.white,
//                     margin: EdgeInsets.all( 10),
//                     child: Text("${snapshot.data[i]["title"]}"));
//                   });
//           }
//           return Center(child: CircularProgressIndicator(),);
//       })
//     );
//   }
// }



// الطريقة الاولى لجلب البيانات

// class HttpApi extends StatefulWidget {
//   const HttpApi({super.key});

//   @override
//   State<HttpApi> createState() => _HttpApiState();
// }

// class _HttpApiState extends State<HttpApi> {

// List posts =[]; // لكي نخزن داخلها البيانات

//  Future getPost() async {
//     var url = Uri.parse("https://jsonplaceholder.typicode.com/posts"); // رابط الموقع api الا بجلب منه البيانات

//     var response = await http.get(url); // لجلب بيانات المجودة في api ضروري هنا يكون في معالجة في حالة لم اقد اوصل لي موقع api
//     var responsebody = jsonDecode(response.body); // لفك ترميز البيانات 
//     posts.addAll(responsebody); 
//     print("Data......: $posts"); // 

//     setState(() { // لكي اعرض البيانات عندي مباشرة في التطبيق
//        posts.addAll(responsebody); 
//     });
    
//   }

//   @override
//   void initState() { // لعرض النتائج 
//     getPost();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("dialog"),
//       ),
//       body: posts == null || posts.isEmpty 
//        ? Center(child: CircularProgressIndicator(),) // هذة الدالة لعمل دائرة تبحث عندما يكون النت ضعيف في حالة كانت القائمة فارغة         
//        : ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, i){
//           return Container(
//             color: Colors.white,
//             margin: EdgeInsets.all( 10),
//             child: Text("${posts[i]["title"]}"));
//       })
//     );
//   }
// }
