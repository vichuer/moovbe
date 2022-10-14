import 'package:get/get.dart';

import '../modules/bus_details/bindings/bus_details_binding.dart';
import '../modules/bus_details/views/bus_details_view.dart';
import '../modules/create_driver/bindings/create_driver_binding.dart';
import '../modules/create_driver/views/create_driver_view.dart';
import '../modules/drivers_list/bindings/drivers_list_binding.dart';
import '../modules/drivers_list/views/drivers_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BUS_DETAILS,
      page: () => const BusDetailsView(),
      binding: BusDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DRIVERS_LIST,
      page: () => DriversListView(),
      binding: DriversListBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_DRIVER,
      page: () => CreateDriverView(),
      binding: CreateDriverBinding(),
    ),
  ];
}
