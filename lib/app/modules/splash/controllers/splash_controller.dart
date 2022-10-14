import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    initSplash();
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

  initSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isLogin') == null) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Get.offNamed('welcome');
      });
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Get.offNamed('home');
      });
    }
  }
}
