class Bus {
  bool? status;
  List<BusList>? busList;

  Bus({this.status, this.busList});

  Bus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['bus_list'] != null) {
      busList = <BusList>[];
      json['bus_list'].forEach((v) {
        busList?.add(BusList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (busList != null) {
      data['bus_list'] = busList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusList {
  int? id;
  String? name;
  String? image;
  String? seatCount;
  String? type;
  int? driver;

  BusList(
      {this.id, this.name, this.image, this.seatCount, this.type, this.driver});

  BusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    seatCount = json['seat_count'];
    type = json['type'];
    driver = json['driver'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['seat_count'] = seatCount;
    data['type'] = type;
    data['driver'] = driver;
    return data;
  }
}
