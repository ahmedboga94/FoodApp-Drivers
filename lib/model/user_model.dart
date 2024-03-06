class UserModel {
  String userName;
  String userEmail;
  String userUID;
  String userPhotoURL;
  String status;

  UserModel({
    required this.status,
    required this.userName,
    required this.userEmail,
    required this.userUID,
    required this.userPhotoURL,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json["userName"],
      userEmail: json["userEmail"],
      userUID: json["userUID"],
      userPhotoURL: json["userPhotoURL"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["userName"] = userName;
    data["userEmail"] = userEmail;
    data["userUID"] = userUID;
    data["userPhotoURL"] = userPhotoURL;
    data["status"] = status;
    return data;
  }
}
