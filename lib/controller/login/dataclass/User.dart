
class User {
  int? id;
  String? name;
  String? number;
  String? license;
  String? password;
  String? image;
  int? carId;
  String? createdAt;
  String? updatedAt;
  Car? car;

  User(
      {this.id,
        this.name,
        this.number,
        this.license,
        this.password,
        this.image,
        this.carId,
        this.createdAt,
        this.updatedAt,
        this.car});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    license = json['license'];
    password = json['password'];
    image = json['image'];
    carId = json['car_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['license'] = this.license;
    data['password'] = this.password;
    data['image'] = this.image;
    data['car_id'] = this.carId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    return data;
  }
}



class Car {
  int? id;
  String? number;
  String? image;
  String? make;
  String? capacity;
  String? year;
  String? dor;
  String? rde;
  String? euro;
  String? fuel;
  String? co;
  String? status;
  String? export;
  String? createdAt;
  String? updatedAt;

  Car(
      {this.id,
        this.number,
        this.image,
        this.make,
        this.capacity,
        this.year,
        this.dor,
        this.rde,
        this.euro,
        this.fuel,
        this.co,
        this.status,
        this.export,
        this.createdAt,
        this.updatedAt});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    image = json['image'];
    make = json['make'];
    capacity = json['capacity'];
    year = json['year'];
    dor = json['dor'];
    rde = json['rde'];
    euro = json['euro'];
    fuel = json['fuel'];
    co = json['co'];
    status = json['status'];
    export = json['export'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['image'] = this.image;
    data['make'] = this.make;
    data['capacity'] = this.capacity;
    data['year'] = this.year;
    data['dor'] = this.dor;
    data['rde'] = this.rde;
    data['euro'] = this.euro;
    data['fuel'] = this.fuel;
    data['co'] = this.co;
    data['status'] = this.status;
    data['export'] = this.export;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}