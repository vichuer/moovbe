import 'package:get/get.dart';

import '../controllers/bus_details_controller.dart';

class BusDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusDetailsController>(
      () => BusDetailsController(),
    );
  }
}
