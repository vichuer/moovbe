class Drivers {
  bool? status;
  List<DriverList>? driverList;

  Drivers({this.status, this.driverList});

  Drivers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['driver_list'] != null) {
      driverList = <DriverList>[];
      json['driver_list'].forEach((v) {
        driverList?.add(DriverList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (driverList != null) {
      data['driver_list'] = driverList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DriverList {
  int? id;
  String? name;
  String? mobile;
  String? licenseNo;

  DriverList({this.id, this.name, this.mobile, this.licenseNo});

  DriverList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    licenseNo = json['license_no'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['license_no'] = licenseNo;
    return data;
  }
}
