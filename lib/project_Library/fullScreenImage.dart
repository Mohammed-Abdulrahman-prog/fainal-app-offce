
import 'package:flutter/material.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;
  final String fileName;

  const FullScreenImagePage(
    {
      super.key, 
      required this.imageUrl,
      required this.fileName,
    });

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Container(
          color: Colors.blue,
          child: Image.network(widget.imageUrl, fit: BoxFit.contain,),
        ),
      ),
    );
  }
}