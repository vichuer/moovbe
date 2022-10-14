import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:moovbe/app/data/api_urls.dart';
import 'package:moovbe/app/data/app_colors.dart';
import 'package:moovbe/app/modules/drivers_list/drivers_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriversListController extends GetxController {
  var drivers = Drivers().obs;
  @override
  void onInit() {
    getDrivers();
    super.onInit();
  }

  Future<void> getDrivers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apikey = prefs.getString('api-key')!;
    String token = prefs.getString('access')!;

    await http.get(Uri.parse(ApiUrls.driverListURL + '$apikey/'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) {
      String data = response.body;
      var json = jsonDecode(data);
      drivers.value = Drivers.fromJson(json);
    });
  }

  deleteConfirm(String id) {
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
          Text('Do you really want to delete this driver ?'),
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
                    child: Text('Back')),
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
                      Get.back();
                      delete(id);
                    },
                    child: Text('Delete')),
              ))
            ],
          )
        ],
      ),
    ));
  }

  Future<void> delete(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apikey = prefs.getString('api-key')!;
    String token = prefs.getString('access')!;
    await http.delete(Uri.parse(ApiUrls.driverListURL + '$apikey/'), body: {
      'driver_id': id
    }, headers: {
      'Authorization': 'Bearer $token',
    }).then((response) {
      log(response.body);
      String data = response.body;
      var json = jsonDecode(data);
      if (response.statusCode == 200) {
        if (json['status'].toString() == 'true') {
          Fluttertoast.showToast(msg: 'Driver deleted sucessfully');
          getDrivers();
        } else {
          Fluttertoast.showToast(msg: 'Failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'Server Error');
      }
    });
  }
}
