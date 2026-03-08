
import 'package:fainal_app_offce/project_Library/ShowImage.dart';
import 'package:fainal_app_offce/project_Library/login.dart';
import 'package:fainal_app_offce/project_Library/upload_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginscreen(),
      // home: Loginscreen(),
    );
  }
}