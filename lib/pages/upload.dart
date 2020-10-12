import 'package:flutter/material.dart';
import 'package:flutter_app/drawer.dart';
class ViewVideo extends StatefulWidget {
  @override
  _ViewVideoState createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
            title:Text("video")
        ),
        body: Text("video")
    );
  }
}

