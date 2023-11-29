class User {
  int? id;
  int? userid;
  String? name;
  String? number;
  String? license;
  String? password;
  String? email;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.userid,
        this.name,
        this.number,
        this.license,
        this.password,
        this.email,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['user_id'];
    name = json['name'];
    number = json['number'];
    license = json['license'];
    password = json['password'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userid;
    data['name'] = name;
    data['number'] = number;
    data['license'] = license;
    data['password'] = password;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}