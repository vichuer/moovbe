import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moovbe/app/data/api_urls.dart';
import 'package:moovbe/app/data/app_colors.dart';
import 'package:moovbe/app/modules/home/bus_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var buses = Bus().obs;

  @override
  void onInit() {
    getBuses();
    super.onInit();
  }

  Future<void> getBuses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apikey = prefs.getString('api-key')!;
    String token = prefs.getString('access')!;

    await http.get(Uri.parse(ApiUrls.busListURL + '$apikey/'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) {
      log(response.body);
      String data = response.body;
      var json = jsonDecode(data);
      buses.value = Bus.fromJson(json);
    });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.offAllNamed('login');

    prefs.clear();
  }

  logoutDialog() {
    Get.dialog(Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Are you sure ?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Text('Do you really want to logout ?'),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('NO')),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.accentColor)),
                    onPressed: () {
                      logout();
                    },
                    child: Text('Yes')),
              ))
            ],
          )
        ],
      ),
    ));
  }
}
