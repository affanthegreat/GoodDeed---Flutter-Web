import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helper/Constants.dart';

class Posts {

  String ?postTitle;
  String ?postDescription;
  String ?itemRequired;
  String ?userPhoneNumber;
  String ?userLocation;
  String ?statename;




  Map<String,dynamic> MapFunction(){
    return {
      "postTitle":postTitle,
      "postDescription": postDescription,
      "itemRequired" : itemRequired,
      "username": loggedinuser!.displayName,
      "useremail": loggedinuser!.email,
      "userLocation":userLocation,
      "statename":statename,
      "datetime":DateTime.now()
    };
  }

  void setPostData() async{
    FirebaseFirestore firestoreInstance = await FirebaseFirestore.instance;
    await firestoreInstance.collection("Posts").doc("").set(MapFunction());
  }

}