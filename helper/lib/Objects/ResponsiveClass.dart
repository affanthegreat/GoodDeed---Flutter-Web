import 'package:flutter/material.dart';
import 'package:helper/Constants.dart';

// class ResponsiveWidget extends StatelessWidget {
//   final Widget largeScreen;
//   final Widget? mediumScreen;
//   final Widget? smallScreen;
//
//   const ResponsiveWidget({
//     Key? key,
//     required this.largeScreen,
//     this.mediumScreen,
//     this.smallScreen,
//   }) : super(key: key);
//
//   static bool isSmallScreen(BuildContext context) {
//     return MediaQuery.of(context).size.width < 800;
//   }
//
//   static bool isLargeScreen(BuildContext context) {
//     return MediaQuery.of(context).size.width > 1200;
//   }
//
//   static bool isMediumScreen(BuildContext context) {
//     return MediaQuery.of(context).size.width >= 800 &&
//         MediaQuery.of(context).size.width <= 1200;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (constraints.maxWidth >= 1200 ) {
//           return largeScreen;
//         } else if (constraints.maxWidth <= 1200 &&
//             constraints.maxWidth >= 800) {
//           return Scaffold(
//             body: Container(
//               margin: EdgeInsets.all(50),
//               child: Center(
//                 child: Text(
//                   "This resolution is not yet supported. Use your PC or Tablet to access the site. Sorry for the inconvenience caused.",
//                   style: TextStyle(
//                     fontSize: subHeadingFontSize2,
//                     fontFamily: poppins,
//                     fontWeight: FontWeight.bold,
//
//                   ),
//                 ),
//               ),
//
//             ),
//           );
//         } else {
//            return Scaffold(
//             body: Container(
//               margin: EdgeInsets.all(50),
//               child: Center(
//                 child: Text(
//                   "This resolution is not yet supported. Use your PC or Tablet to access the site. Sorry for the inconvenience caused.",
//                   style: TextStyle(
//                     fontSize: subHeadingFontSize2,
//                     fontFamily: poppins,
//                     fontWeight: FontWeight.bold,
//
//                   ),
//                 ),
//               ),
//
//             ),
//           );
//         }
//       },
//     );
//   }
// }
class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return largeScreen;
        } else if (constraints.maxWidth <= 1200 &&
            constraints.maxWidth >= 800) {

          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}