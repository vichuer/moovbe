import 'package:get/get.dart';

import '../controllers/create_driver_controller.dart';

class CreateDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateDriverController>(
      () => CreateDriverController(),
    );
  }
}
