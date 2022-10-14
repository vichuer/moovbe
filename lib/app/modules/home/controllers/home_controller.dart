import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:moovbe/app/data/api_urls.dart';
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
}
