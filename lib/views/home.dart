import 'dart:io';

import 'package:blog_app/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/views/create_blog.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  QuerySnapshot blogsSnapshot;

  Widget BlogList() {
    return Container(
      child: blogsSnapshot != null
          ? Column(children: <Widget>[
              ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: blogsSnapshot.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BlogsTile(
                      authorName: blogsSnapshot.docs[index].get('authorName'),
                      title: blogsSnapshot.docs[index].get('title'),
                      description: blogsSnapshot.docs[index].get('desc'),
                      imgUrl: blogsSnapshot.docs[index].get('imgUrl'),
                    );
                  })
            ])
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  void initState() {
    super.initState();

    crudMethods.getData().then((result) {
      //to rebuilt the widget with new data (blogsSnapshot)
      setState(() {
        blogsSnapshot = result;
      });
      //only setState was missing and some methods where depricated(still works).
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              "Ghumo",
              style: TextStyle(fontSize: 22),
            ),
            Text("App", style: TextStyle(fontSize: 22, color: Colors.red))
          ],
        ),
      ),
      body: BlogList(),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 175),
        child: Row(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;
  BlogsTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.description,
      @required this.authorName});

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 16),
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imgUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(description,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 4,
                  ),
                  Text(authorName),
                ],
              ),
            ),
          ],
        ));
  }
}
