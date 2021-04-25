import 'package:flutter/material.dart';
import 'package:helper/Objects/Posts.dart';

import '../Constants.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  Posts post = new Posts();

  @override
  Widget build(BuildContext context) {
    //MediaQueries
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    //Navigation Bar items
    Widget navBarItem(String text) {
      bool hoverBool = false;
      return Container(
        margin: EdgeInsets.only(top: height * 0.023, right: height * 0.03),
        child: InkWell(
          onHover: (val) {
            setState(() {
              hoverBool = val;
            });
          },
          child: Text(
            text,
            style: TextStyle(
                color: foregroundColor,
                fontSize: subHeadingFontSize,
                fontFamily: poppins,
                fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: boxInnerColor,
        title: Text(
          "Good Deed",
          style: TextStyle(
              color: titleColor,
              fontSize: 33,
              fontFamily: poppins,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0.6,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: boxInnerColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    navBarItem("Help others"),
                    navBarItem("Your Posts"),
                    navBarItem("Contact Us"),
                    navBarItem("About"),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin:EdgeInsets.all(15),
                          child: Text("New Post",
                          style: TextStyle(
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                            color: foregroundColor
                          ),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin:EdgeInsets.all(15),
                          child: Text("Make sure be as precise as possible with title as this increases the audience of your post making. ",
                            style: TextStyle(
                                fontFamily: poppins,
                                fontWeight: FontWeight.bold,
                                fontSize: subHeadingFontSize2,
                                color: foregroundColor
                            ),),
                        ),
                      ],
                    )
                  ],
                ),


          )),
          Expanded(
              flex: 10,
              child: Container(
                color: Colors.green,

              )),
          Expanded(
              flex: 8,
              child: Container(
                color: Colors.blue,

              ))
        ],
      ),
    );
  }
}
