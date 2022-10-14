import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moovbe/app/data/api_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController unameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login() async {
    var body = {
      'username': unameController.text,
      'password': passController.text
    };
    await http.post(Uri.parse(ApiUrls.loginURL), body: body).then((response) {
      log(response.body);
      String data = response.body;
      var json = jsonDecode(data);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (json['status'].toString() == 'true') {
          saveDetails(
              json['refresh'], json['name'], json['access'], json['url_id']);
        } else {
          Fluttertoast.showToast(msg: 'Invalid USername or Passwors');
        }
      } else {
        Fluttertoast.showToast(msg: 'Server Error');
      }
    });
  }

  saveDetails(String refresh, String name, String access, String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refresh', refresh);
    prefs.setString('access', access);
    prefs.setString('api-key', apiKey);
    prefs.setString('name', name);
    prefs.setBool('isLogin', true);
    Get.offAllNamed('home');
    Fluttertoast.showToast(msg: 'Welcome $name');
  }

  validateFields() {
    if (unameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Username');
    } else if (unameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Password');
    } else {
      login();
    }
  }
}
