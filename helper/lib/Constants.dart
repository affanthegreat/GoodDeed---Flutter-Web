//api end points

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var covidStats = "https://api.rootnet.in/covid19-in/stats/latest";
var hospitalBeds = "https://api.rootnet.in/covid19-in/hospitals/beds";
var testingStats  = "https://api.rootnet.in/covid19-in/stats/testing/latest";
var medicalColleges = "https://api.rootnet.in/covid19-in/hospitals/medical-colleges";



//User
User? loggedinuser;

//Statewise fitlers
var stateswiseLists = [];
var copyStatesList = [];


//search queries
String stateSearchQuery = "";

//Custom Fonts
String poppins = "Poppins";

//Controlllers and physics
ScrollController _scrollController = ScrollController();


//Color palattes
Color backgroundColor = Colors.grey.shade50;
Color foregroundColor = Colors.black;
Color titleColor = Colors.blueGrey.shade800;
Color subtitleColor = Colors.blueGrey.shade700;
Color divColor = Colors.blueGrey.shade300;
Color divColor2 = Colors.blueGrey.shade500;
Color boxInnerColor = Colors.white;
Color boxBorderLight = Colors.blueGrey.shade100;
Color boxBorderColor = Colors.blueGrey.shade200;
Color navHoverColor = Colors.blue;

//fontsizes
double normalFontSize = 12;
double subHeadingFontSize = 16;
double subHeadingFontSize2 = 19;
double titleFontSize = 32;
double smallFontSize = 10;


// double normalFontSize = 12;
// double subHeadingFontSize = 15;
// double subHeadingFontSize2 = 18;
// double titleFontSize = 30;
// double smallFontSize = 10;


//Demo Data
//To be removed later
List<int> MultiData = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40,
  41,
  42,
  43,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  55,
  56,
  57,
  58,
  59,
  60,
  61,
  62,
  63,
  64,
  65,
  66,
  67,
  68,
  69,
  70,
  71,
  72,
  73,
  74,
  75,
  76,
  77,
  78,
  79,
  80,
  81,
  82,
  83,
  84,
  85,
  86,
  87,
  88,
  89,
  90,
  91,
  92,
  93,
  94,
  95,
  96,
  97,
  98,
  99
];