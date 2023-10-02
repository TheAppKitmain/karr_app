class User {
  int? id;
  String? name;
  String? number;
  String? license;
  String? password;
  String? email;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.number,
        this.license,
        this.password,
        this.email,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['license'] = this.license;
    data['password'] = this.password;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}