import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moovbe/app/data/api_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateDriverController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController licenseController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validateFields() async {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Name !');
    } else if (licenseController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter License Number !');
    } else if (mobileController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Mobile Number !');
    } else {
      addDriver();
    }
  }

  Future<void> addDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apikey = prefs.getString('api-key')!;
    String token = prefs.getString('access')!;

    var body = {
      'name': nameController.text,
      'license_no': licenseController.text,
      'mobile': mobileController.text
    };
    var headers = {
      // 'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await http
        .post(Uri.parse(ApiUrls.driverListURL + '$apikey/'),
            body: body, headers: headers)
        .then((response) {
      log(response.body);
      String data = response.body;
      var json = jsonDecode(data);
      if (response.statusCode == 200) {
        if (json['status'].toString() == 'true') {
          Fluttertoast.showToast(msg: 'Successfully created new driver');
          nameController.clear();
          mobileController.clear();
          licenseController.clear();
        } else {
          Fluttertoast.showToast(msg: 'Creation failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'Server Error');
      }
    });
  }
}
