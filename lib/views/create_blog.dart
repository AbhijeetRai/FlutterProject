import 'dart:io';

import 'package:blog_app/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';


class CreateBlog extends StatefulWidget {

  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {

  String authorName, title, desc;

  File selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadBlog() async {

    if(selectedImage != null) {

      setState(() {
       _isLoading = true; 
      });

      Reference firebaseStorageRef = FirebaseStorage.instance
      .ref()
      .child("blogImages")
      .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage); 
      
      var imageUrl;
      await task.whenComplete(() async {
        try {
          imageUrl = await firebaseStorageRef.getDownloadURL();
        } catch (onError) {
          print("Error");
        }

        print(imageUrl);
        Navigator.pop(context);
      });

    } else {

    }
  }

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
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector( 
            onTap: () {
              uploadBlog(); 
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.file_upload),
            ),
          ),
        ],
      ),
      body: _isLoading 
      ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(), 
      ) 
      : Container(
        child: Column(
          children: <Widget> [
            SizedBox(
              height: 10
            ),
            GestureDetector(
              onTap: () {
                getImage();
              }, 
              child: selectedImage != null
              ? Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.file(
                  selectedImage,
                  fit: BoxFit.cover,
                  )
                ),
              )
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(6),
                ),
                width: MediaQuery.of(context).size.width,
                child: Icon(
                  Icons.add_a_photo, 
                  color: Colors.black, 
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: "Author Name"),
                    onChanged: (val) {
                      authorName = val;
                    }, 
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Title"),
                    onChanged: (val) {
                      title = val;
                    }, 
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Desc"),
                    onChanged: (val) {
                      desc = val;
                    }, 
                  ),
                ]
              ),
            ),
          ]
        ),
      ), 
    );
  }
}