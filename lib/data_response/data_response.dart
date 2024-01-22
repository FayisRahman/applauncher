import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataResponse with ChangeNotifier {
  SharedPreferences? pref;
  String familyName = "";

  void setFamilyName(String data) {
    familyName = data;
  }

  void setPref(SharedPreferences data) {
    pref = data;
  }
}
