class News{
  String _headline;
  String _description;
  String _imgurl;
  String _Date;

  News(this._headline, this._description, this._imgurl, this._Date);

  String get headline => _headline;

  String get Date => _Date;

  set Date(String value) {
    _Date = value;
  }

  String get imgurl => _imgurl;

  set imgurl(String value) {
    _imgurl = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set headline(String value) {
    _headline = value;
  }


}