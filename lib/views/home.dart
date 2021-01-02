import 'package:flutter/material.dart';
import 'package:blog_app/views/create_blog.dart';

class HomePage extends StatefulWidget {

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              "Ghumo",
              style: TextStyle(
                 fontSize: 22
              ),
            ),
            Text(
              "App",
              style: TextStyle(
                fontSize: 22,
                color: Colors.red
              )
            )
          ],
        ),
      ),
      body: Container(),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 175),
        child: Row(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:  (context) => CreateBlog()));
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}