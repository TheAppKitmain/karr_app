import 'package:kaar/controller/login/dataclass/User.dart';
class LoginDataClass {
  String? message;
  bool? status;
  User? user;
  String? car;

  LoginDataClass({this.message, this.status, this.user, this.car});

  LoginDataClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    car = json['car'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['car'] = this.car;
    return data;
  }
}