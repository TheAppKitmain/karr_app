class ActivityDataClass {
  String? message;
  List<Tickets>? tickets;
  List<Tolls>? tolls;
  List<Charges>? charges;
  bool? status;

  ActivityDataClass(
      {this.message, this.tickets, this.tolls, this.charges, this.status});

  ActivityDataClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
    if (json['tolls'] != null) {
      tolls = <Tolls>[];
      json['tolls'].forEach((v) {
        tolls!.add(new Tolls.fromJson(v));
      });
    }
    if (json['charges'] != null) {
      charges = <Charges>[];
      json['charges'].forEach((v) {
        charges!.add(new Charges.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    if (this.tolls != null) {
      data['tolls'] = this.tolls!.map((v) => v.toJson()).toList();
    }
    if (this.charges != null) {
      data['charges'] = this.charges!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Tickets {
  int? id;
  String? pcn;
  String? date;
  String? ticketIssuer;
  String? price;
  String? notes;
  int? status;
  int? driverId;
  String? createdAt;
  String? updatedAt;

  Tickets(
      {this.id,
        this.pcn,
        this.date,
        this.ticketIssuer,
        this.price,
        this.notes,
        this.status,
        this.driverId,
        this.createdAt,
        this.updatedAt});

  Tickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pcn = json['pcn'];
    date = json['date'];
    ticketIssuer = json['ticket_issuer'];
    price = json['price'];
    notes = json['notes'];
    status = json['status'];
    driverId = json['driver_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pcn'] = this.pcn;
    data['date'] = this.date;
    data['ticket_issuer'] = this.ticketIssuer;
    data['price'] = this.price;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['driver_id'] = this.driverId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Tolls {
  String? name;
  int? id;
  String? pd;
  int? paytollId;
  int? driverId;
  String? status;
  String? way;
  String? date;
  int? userId;
  String? notes;
  bool? ischecked;
  String? createdAt;
  String? updatedAt;

  Tolls(
      {this.name,
        this.id,
        this.pd,
        this.paytollId,
        this.driverId,
        this.status,
        this.way,
        this.date,
        this.userId,
        this.notes,
        this.ischecked,
        this.createdAt,
        this.updatedAt});

  Tolls.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    pd = json['pd'];
    paytollId = json['paytoll_id'];
    driverId = json['driver_id'];
    status = json['status'];
    way = json['way'];
    date = json['date'];
    userId = json['user_id'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['pd'] = this.pd;
    data['paytoll_id'] = this.paytollId;
    data['driver_id'] = this.driverId;
    data['status'] = this.status;
    data['way'] = this.way;
    data['date'] = this.date;
    data['user_id'] = this.userId;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Charges {
  String? name;
  int? id;
  String? cd;
  int? cityId;
  int? driverId;
  String? status;
  String? date;
  int? userId;
  String? notes;
  bool? ischecked;
  String? createdAt;
  String? updatedAt;

  Charges(
      {this.name,
        this.id,
        this.cd,
        this.cityId,
        this.driverId,
        this.status,
        this.date,
        this.userId,
        this.ischecked,
        this.notes,
        this.createdAt,
        this.updatedAt});

  Charges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    cd = json['cd'];
    cityId = json['city_id'];
    driverId = json['driver_id'];
    status = json['status'];
    date = json['date'];
    userId = json['user_id'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['cd'] = this.cd;
    data['city_id'] = this.cityId;
    data['driver_id'] = this.driverId;
    data['status'] = this.status;
    data['date'] = this.date;
    data['user_id'] = this.userId;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
