class TicketDataClass {
  bool? status;
  String? message;
  List<Tickets>? tickets;

  TicketDataClass({this.status, this.message, this.tickets});

  TicketDataClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
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
