import 'package:flutter/material.dart';
import 'package:helper/Constants.dart';
import 'package:helper/Objects/CovidStates.dart';

class PP extends StatefulWidget {
  @override
  _PPState createState() => _PPState();
}

class _PPState extends State<PP> {
  @override
  Widget build(BuildContext context) {
    //MediaQueries
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var screenSize = MediaQuery.of(context).size;


    //helper object

    Widget infoText(String title, String subtitle) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              textScaleFactor: 0.8,
              style: TextStyle(
                  color: subtitleColor,
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize),
            ),
            Text(
              subtitle,
              textScaleFactor: 0.8,
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

    //main object

    Widget StatesButtons(States state) {
      return Container(
        width: width * 0.13,
        height: height * 0.2,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: boxInnerColor,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            state.name.toString(),
                            textScaleFactor: 0.8,
                            style: TextStyle(
                              color: foregroundColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: poppins,
                              fontSize: titleFontSize,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          infoText(
                              state.totalHostpitals() == 0?"No data Available": (state.totalHostpitals()).toString(), "Hospitals"),
                          infoText(state.totalBeds().toString(), "Beds available"),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          infoText(
                              state.confirmedcases.toString(), "Confirmed Cases"),
                          infoText(state.discharges.toString(), "Discharged"),
                          infoText(state.deaths.toString(), "Lost their Lives")
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
      );
    }








    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black.withOpacity(0.35),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(height * 0.02),
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: divColor, width: 0.10),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  10.0, // Move to right 10  horizontally
                  10.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 30, left: 50),
                      child: Text(
                        "Search by state name",
                        style: TextStyle(
                          color: foregroundColor,
                          fontFamily: poppins,
                          fontSize: subHeadingFontSize2,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 50, right: 50),
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          copyStatesList = stateswiseLists;
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              ),
              Container(
                height: height * 0.04,
                margin: EdgeInsets.all(height * 0.02),
                width: width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: divColor, width: 0.10),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        10.0, // Move to right 10  horizontally
                        10.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      onChanged: (value) {
                        var tempList = [];
                        stateswiseLists.forEach((state) {
                          if (state.name
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            tempList.add(state);
                          }
                        });
                        print(tempList.length);
                        setState(() {
                          copyStatesList = tempList;
                        });
                        print(copyStatesList.length);

                      },
                      style: TextStyle(
                          color: foregroundColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: poppins,
                          fontSize: subHeadingFontSize2),
                      decoration: null),
                ),
              ),
              Container(
                height: height * 0.75,
                width: width * 0.5,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: copyStatesList.length,
                    itemBuilder: (context, index) {
                      if(copyStatesList.isEmpty){
                        return Container(
                          height: 200,
                          width: 200,
                          child: Center(
                            child: Text("No State found with that name"),
                          ),
                        );
                      }
                      return StatesButtons(copyStatesList[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
