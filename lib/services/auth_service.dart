// ignore_for_file: avoid_print, camel_case_types, file_names

import 'package:shared_preferences/shared_preferences.dart';

class authServices {
  static void simpanAkun(String username, String password) async {
    //bikin shared preferencesnya
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    //simpan datanya ke lokal
    sharedPref.setString('username', username);
    sharedPref.setString('password', password);

    //nyoba ngambil data yang disimpan
    print(sharedPref.getString('username'));
    print(sharedPref.getString('password'));
  }

  static Future<bool> login(String username, String password) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (username == sharedPref.getString('username') &&
        password == sharedPref.getString('password')) {
      return true;
    }
    return false;
  }
}
