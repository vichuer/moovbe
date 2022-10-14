import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:moovbe/app/data/api_urls.dart';
import 'package:moovbe/app/data/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BusDetailsController extends GetxController {
  var params = Get.parameters;
  int itemCount = 0;
  var drivername = ''.obs;
  var licenseno = ''.obs;
  var driverid = '';
  var json = [];

  @override
  void onInit() {
    itemCount = (double.parse(params['seat']!) ~/ 4).toInt();
    driverid = params['driver']!;
    getDrivers();
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

      json = jsonDecode(data)['driver_list'];
      json.forEach((value) {
        if (driverid == value['id'].toString()) {
          drivername.value = value['name'];
          licenseno.value =
              value['license_no'] == null ? '' : value['license_no'];
        }
      });
    });
  }

  assignDriver(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apikey = prefs.getString('api-key')!;
    String token = prefs.getString('access')!;
    var body = {'bus_id': params['bus_id'], 'driver_id': id};
    await http
        .patch(Uri.parse(ApiUrls.assignURL + '$apikey/'), body: body, headers: {
      'Authorization': 'Bearer $token',
    }).then((response) {
      String data = response.body;
      var json1 = jsonDecode(data);
      if (response.statusCode == 200) {
        if (json1['status'].toString() == 'true') {
          Fluttertoast.showToast(msg: 'Diver is assigned successfully');
          json.forEach((value) {
            if (id == value['id'].toString()) {
              drivername.value = value['name'];
              licenseno.value =
                  value['license_no'] == null ? '' : value['license_no'];
            }
          });
        } else {
          Fluttertoast.showToast(msg: 'Failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'Server Error');
      }
    });
  }

  showAssignDialog() {
    Get.dialog(Dialog(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Assign Driver',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: json.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                  json[index]['name'] == null ? 'Name' : json[index]['name']),
              subtitle: Text(json[index]['license_no'] == null
                  ? 'License No. :'
                  : 'License No. : ' + json[index]['license_no'].toString()),
              trailing: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.accentColor)),
                  onPressed: () {
                    Get.back();
                    assignDriver(json[index]['id'].toString());
                  },
                  child: Text('Assign')),
            ),
          ))
        ],
      ),
    ));
  }
}
