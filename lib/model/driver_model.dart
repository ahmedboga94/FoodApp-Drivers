class DriverModel {
  final String driverUID;
  final String driverEmail;
  final String driverName;
  final String driverPhone;
  final String driverAddress;
  final String driverPhotoURL;
  final String status;
  final double latitude;
  final double longitude;

  final num earning;

  DriverModel({
    required this.driverUID,
    required this.driverEmail,
    required this.driverName,
    required this.driverPhone,
    required this.driverAddress,
    required this.driverPhotoURL,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.earning,
  });
  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      driverUID: json["driverUID"],
      driverEmail: json["driverEmail"],
      driverName: json["driverName"],
      driverPhone: json["driverPhone"],
      driverAddress: json["driverAddress"],
      driverPhotoURL: json["driverPhotoURL"],
      status: json["status"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      earning: json["earning"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["driverUID"] = driverUID;
    data["driverEmail"] = driverEmail;
    data["driverName"] = driverName;
    data["driverPhone"] = driverPhone;
    data["driverAddress"] = driverAddress;
    data["driverPhotoURL"] = driverPhotoURL;
    data["status"] = status;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["earning"] = earning;
    return data;
  }
}
