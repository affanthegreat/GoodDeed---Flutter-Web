import 'package:flutter/material.dart';
import 'package:helper/Objects/ResponsiveClass.dart';
import 'package:helper/Remake/Homepage.dart';
import 'package:helper/Remake/PostPage.dart';
import 'package:sizer/sizer.dart';

void main() {

  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: GoodDeedHomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(

          theme: ThemeData.light(),
          home: ResponsiveWidget(largeScreen: NewPost()) ,
        );
      },
    );
  }
}