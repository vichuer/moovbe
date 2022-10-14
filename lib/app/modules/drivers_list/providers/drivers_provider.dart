import 'package:get/get.dart';

import '../drivers_model.dart';

class DriversProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Drivers.fromJson(map);
      if (map is List)
        return map.map((item) => Drivers.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Drivers?> getDrivers(int id) async {
    final response = await get('drivers/$id');
    return response.body;
  }

  Future<Response<Drivers>> postDrivers(Drivers drivers) async =>
      await post('drivers', drivers);
  Future<Response> deleteDrivers(int id) async => await delete('drivers/$id');
}
