import 'package:get/get.dart';

import '../bus_model.dart';

class BusProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Bus.fromJson(map);
      if (map is List) return map.map((item) => Bus.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Bus?> getBus(int id) async {
    final response = await get('bus/$id');
    return response.body;
  }

  Future<Response<Bus>> postBus(Bus bus) async => await post('bus', bus);
  Future<Response> deleteBus(int id) async => await delete('bus/$id');
}
