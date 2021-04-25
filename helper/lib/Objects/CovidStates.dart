class States{
  String name = "";
  int confirmedcases = 0;
  int discharges =0;
  int deaths =0;
  int ruralhospitals =0;
  int ruralbeds =0;
  int urbanhospitals = 0;
  int urbanbeds =0;




  totalHostpitals(){
    return ruralhospitals+ urbanhospitals;
  }
  totalBeds(){
    return ruralbeds + urbanbeds;
  }
}
