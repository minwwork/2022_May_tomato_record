import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_record/constants/shared_pref_keys.dart';
import 'package:tomato_record/utils/logger.dart';


class UserProvider extends ChangeNotifier{
  UserProvider(){
    initUser();
  }
  User? _user;

  void initUser(){
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      logger.d('user status - $user');
      notifyListeners();
    });
  }

  void _setNewUser(User? user) async {
    _user = user;
    if(user! == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      double lat = prefs.getDouble(SHARED_LAT) ?? 0;
      double lon = prefs.getDouble(SHARED_LON) ?? 0;
      String phoneNumber = user.phoneNumber!;
      String userKey = user.uid;

    }
  }

  User? get user => _user;

}