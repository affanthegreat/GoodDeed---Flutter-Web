import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helper/Constants.dart';
import 'package:helper/Firebase/FirebaseCore.dart';
import 'package:helper/Objects/AdaptableText.dart';
import 'package:helper/Objects/CovidStates.dart';
import 'package:helper/Objects/ResponsiveClass.dart';
import 'package:helper/Remake/PostPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'PP.dart';

class GoodDeedHomePageRemade extends StatefulWidget {
  @override
  _GoodDeedHomePageRemadeState createState() => _GoodDeedHomePageRemadeState();
}

class _GoodDeedHomePageRemadeState extends State<GoodDeedHomePageRemade> {
  //Stats
  var totalCasesConfirmed;
  var totalDischarged;
  var totaldeaths;
  var totalHospitals;
  var totalbeds;
  var totalRuralBeds;
  var totalUrbanBeds;
  var totalRuralHospitals;
  var totalUrbanHosptials;
  var totalSamplesTested;

  //loading
  bool isLoading = false;
  bool isLoading2 = false;
  bool loggedInState = false;

  //imageslist
  var imagesList = [
    "1.jpg",
    "2.jpg",
    "3.jpg",
    "4.jpg",
    "5.jpg",
    "6.jpg",
    "7.jpg",
    "8.jpg",
  ];
  var imageShowList = [];

  //imagesLoader
  imgloader() {
    for (int i = 0; i < imagesList.length; i++) {
      var img = Image.asset("images/" + imagesList[i]);
      imageShowList.add(img);
    }
  }

  precacheImages() {
    for (int i = 0; i < imageShowList.length; i++) {
      precacheImage(imageShowList[i].image, context);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImages();
  }

  //init
  @override
  void initState() {
    // TODO: implement initState
    apiDataGetter();
    imgloader();

    super.initState();
  }

  //api calls
  void apiDataGetter() async {
    //start loading screen
    setState(() {
      isLoading = true;
    });

    //responses
    var covidResponse = await http.get(Uri.parse(covidStats));
    var bedResponse = await http.get(Uri.parse(hospitalBeds));
    var testingResponse = await http.get(Uri.parse(testingStats));
    var MedicalCollegeResponse = await http.get(Uri.parse(medicalColleges));

    //string to Map
    var covidResponseMap = jsonDecode(covidResponse.body);
    var bedResponseMap = jsonDecode(bedResponse.body);
    var testingResponseMap = jsonDecode(testingResponse.body);
    var medicalCollegeMap = jsonDecode(MedicalCollegeResponse.body);

    //stats assignment
    setState(() {
      totalCasesConfirmed = indianNumConvert(
          covidResponseMap["data"]["summary"]["total"].toString());
      totalDischarged = indianNumConvert(
          covidResponseMap["data"]["summary"]["discharged"].toString());
      totaldeaths = indianNumConvert(
          covidResponseMap["data"]["summary"]["deaths"].toString());
      totalbeds = indianNumConvert(
          bedResponseMap["data"]["summary"]["totalBeds"].toString());
      totalHospitals = indianNumConvert(
          bedResponseMap["data"]["summary"]["totalHospitals"].toString());
      totalRuralBeds = indianNumConvert(
          bedResponseMap["data"]["summary"]["ruralBeds"].toString());
      totalRuralHospitals = indianNumConvert(
          bedResponseMap["data"]["summary"]["ruralHospitals"].toString());
      totalUrbanBeds = indianNumConvert(
          bedResponseMap["data"]["summary"]["urbanBeds"].toString());
      totalUrbanHosptials = indianNumConvert(
          bedResponseMap["data"]["summary"]["urbanHospitals"].toString());
      totalSamplesTested = indianNumConvert(
          testingResponseMap["data"]["totalSamplesTested"].toString());
    });

    for (int i = 0; i < covidResponseMap["data"]["regional"].length; i++) {
      States newState = new States();
      var currentMap = covidResponseMap["data"]["regional"][i];
      newState.name = currentMap["loc"];
      newState.confirmedcases = currentMap["totalConfirmed"];
      newState.deaths = currentMap["deaths"];
      newState.discharges = currentMap["discharged"];

      for (int j = 0; j < bedResponseMap["data"]["regional"].length; j++) {
        if (currentMap["loc"] ==
            bedResponseMap["data"]["regional"][j]["state"]) {
          newState.ruralbeds =
              bedResponseMap["data"]["regional"][j]["ruralBeds"];
          newState.ruralhospitals =
              bedResponseMap["data"]["regional"][j]["ruralHospitals"];
          newState.urbanbeds =
              bedResponseMap["data"]["regional"][j]["urbanBeds"];
          newState.urbanhospitals =
              bedResponseMap["data"]["regional"][j]["urbanHospitals"];

          break;
        }
      }
      stateswiseLists.add(newState);
    }
    copyStatesList = stateswiseLists;
    print(stateswiseLists.length);
    //end loading screen
    setState(() {
      isLoading = false;
    });
  }

  //indian unit convertion

  String indianNumConvert(String x) {
    String result = "";

    var y = x.split("").reversed.join();
    for (int i = 0; i < x.length; i++) {
      if (i == 2) {
        result += y[i];
        result += ",";
      } else if (i > 2 && i % 2 == 0 && i + 1 < x.length) {
        result += y[i];
        result += ",";
      } else {
        result += y[i];
      }
    }

    return result.split("").reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    //MediaQueries
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var screenSize = MediaQuery.of(context).size;

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

    Widget googleSignIn() {
      return Container(
        margin: EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
            color: boxInnerColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: foregroundColor, width: 0.1)),
        child: InkWell(
          onTap: () async {
            User? user =
                await Authentication.signInWithGoogle(context: context);
            loggedinuser = user;
            print(loggedinuser!.uid);
            if (user != null) {
              setState(() {
                loggedInState = true;
              });
            }
          },
          child: Center(
            child: loggedInState
                ? Container(
                    child: Text(
                      loggedinuser!.displayName.toString(),
                      style: TextStyle(
                          color: foregroundColor,
                          fontSize: subHeadingFontSize,
                          fontFamily: poppins,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                        width: 20,
                        image: AssetImage('google.png'),
                      ),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                            color: foregroundColor,
                            fontFamily: poppins,
                            fontSize: normalFontSize,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
          ),
        ),
      );
    }

    //buttons
    Widget requestBox(String txt) {
      return Container(
        margin: EdgeInsets.all(height * 0.01),
        height: height * 0.04,
        decoration: BoxDecoration(
            border: Border.all(color: boxBorderLight),
            color: boxInnerColor,
            borderRadius: BorderRadius.circular(height * 0.001)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Title",
                    style: TextStyle(
                      color: foregroundColor,
                      fontFamily: poppins,
                      fontWeight: FontWeight.w600,
                      fontSize: subHeadingFontSize2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget smallInfoBox(String title, String subTitle) {
      return Container(
        margin: EdgeInsets.all(height * 0.01),
        decoration: BoxDecoration(
            border: Border.all(color: boxBorderLight),
            color: boxInnerColor,
            borderRadius: BorderRadius.circular(height * 0.001)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: foregroundColor,
                        fontFamily: poppins,
                        fontWeight: FontWeight.w600,
                        fontSize: subHeadingFontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      subTitle,
                      style: TextStyle(
                        color: foregroundColor,
                        fontFamily: poppins,
                        fontWeight: FontWeight.w500,
                        fontSize: normalFontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget infoText(String title, String subtitle) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: subtitleColor,
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize),
            ),
            Text(
              subtitle,
              style: TextStyle(
                  color: foregroundColor,
                  fontFamily: poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: subHeadingFontSize),
            ),
          ],
        ),
      );
    }

    Widget postButton(String txt, bool ems, Image img) {
      return Container(
        width: ems ? 350 : 450,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: img.image, fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  10.0, // Move to right 10  horizontally
                  10.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            border: Border.all(color: divColor, width: 0.2)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.transparent,
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.4),
                Colors.white.withOpacity(0.5)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                  child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Title",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              color: foregroundColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: poppins,
                              fontSize: subHeadingFontSize2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Subtitle",
                            style: TextStyle(
                              color: foregroundColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: poppins,
                              fontSize: subHeadingFontSize2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Date",
                        style: TextStyle(
                          color: foregroundColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: poppins,
                          fontSize: smallFontSize,
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      );
    }

    Widget infoButton() {
      return AnimatedContainer(
        duration: Duration(seconds: 1),
      );
    }

    //text

    //Main Objects
    Widget RequestBox() {
      return Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: divColor, width: 0.15),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      15.0, // Move to right 10  horizontally
                      15.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Recent requests",
                          style: TextStyle(
                              color: subtitleColor,
                              fontFamily: poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: subHeadingFontSize2),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: MultiData.length,
                          itemBuilder: (context, index) {
                            return requestBox(MultiData[index].toString());
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget MainBox() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: divColor, width: 0.15),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                15.0, // Move to right 10  horizontally
                15.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "News on Emergency services",
                    style: TextStyle(
                        color: subtitleColor,
                        fontFamily: poppins,
                        fontWeight: FontWeight.w600,
                        fontSize: subHeadingFontSize2),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemCount: MultiData.length,
                    itemBuilder: (context, index) {
                      return postButton(MultiData[index].toString(), false,
                          imageShowList[index % imageShowList.length]);
                    }),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Emergency Requests",
                    style: TextStyle(
                        color: subtitleColor,
                        fontFamily: poppins,
                        fontWeight: FontWeight.w600,
                        fontSize: subHeadingFontSize2),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemCount: MultiData.length,
                    itemBuilder: (context, index) {
                      return postButton(MultiData[index].toString(), true,
                          imageShowList[(index + 4) % imageShowList.length]);
                    }),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemCount: MultiData.length,
                    itemBuilder: (context, index) {
                      return postButton(MultiData[index].toString(), true,
                          imageShowList[(index + 6) % imageShowList.length]);
                    }),
              ),
            ),
          ],
        ),
      );
    }

    Widget CovidInformationBox() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: divColor, width: 0.15),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                15.0, // Move to right 10  horizontally
                15.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: isLoading
            ? Container(
                child: Center(
                  child: Text(
                    "Hold on a moment",
                    style: TextStyle(
                        color: subtitleColor,
                        fontFamily: poppins,
                        fontWeight: FontWeight.bold,
                        fontSize: subHeadingFontSize),
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          infoText(
                              totalCasesConfirmed, "Cases confirmed in India"),
                          infoText(totalDischarged, "got discharged"),
                          infoText(totaldeaths, "Lost their lives"),
                          infoText(totalSamplesTested, "Samples tested")
                        ],
                      ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "*Covid-19",
                          style: TextStyle(
                              color: subtitleColor,
                              fontFamily: poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: normalFontSize),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      );
    }

    Widget detailedInformationBox() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: divColor, width: 0.15),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 25.0,
              spreadRadius: 1.0,
              offset: Offset(
                15.0,
                15.0,
              ),
            )
          ],
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Detailed Info",
                        style: TextStyle(
                            color: subtitleColor,
                            fontFamily: poppins,
                            fontWeight: FontWeight.w600,
                            fontSize: subHeadingFontSize2),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) =>
                                      ResponsiveWidget(largeScreen: PP())));
                            });
                          },
                          child: smallInfoBox("State Wise Information",
                              "Information related to Covid-19 from every state of India")),
                      smallInfoBox("View all Posts", "See all posts"),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double>
                                    secondaryAnimation) =>
                                    ResponsiveWidget(largeScreen: NewPost())));
                          });
                        },
                        child:
                            smallInfoBox("Make a new post", "Create a new post about the issue you are facing and let others help you."),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
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
        actions: [googleSignIn()],
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
              flex: 18,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(flex: 3, child: RequestBox()),
                            Expanded(flex: 1, child: Container())
                          ],
                        )),
                    Expanded(flex: 5, child: MainBox()),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(flex: 4, child: CovidInformationBox()),
                            Expanded(flex: 3, child: detailedInformationBox()),
                          ],
                        ))
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                color: foregroundColor,
                child: Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Made by Affan",
                    style: TextStyle(
                        color: backgroundColor,
                        fontSize: subHeadingFontSize,
                        fontWeight: FontWeight.w600,
                        fontFamily: poppins),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
