class AllCityChargesDataClass {
  bool? status;
  String? message;
  List<Charges>? charges;

  AllCityChargesDataClass({this.status, this.message, this.charges});

  AllCityChargesDataClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['charges'] != null) {
      charges = <Charges>[];
      json['charges'].forEach((v) {
        charges!.add(new Charges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.charges != null) {
      data['charges'] = this.charges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Charges {
  int? id;
  String? price;
  String? city;
  String? time;
  String? area;
  int? status;
  String? note;
  bool? ischecked;
  String? createdAt;
  String? updatedAt;

  Charges(
      {this.id,
        this.price,
        this.city,
        this.time,
        this.area,
        this.status,
        this.note,
        this.ischecked,
        this.createdAt,
        this.updatedAt});

  Charges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    city = json['city'];
    time = json['time'];
    area = json['area'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['city'] = this.city;
    data['time'] = this.time;
    data['area'] = this.area;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
