class Ticket {
  final int id;
  final String pcnNumber;
  final String date;
  final String note;

  Ticket({
    required this.id,
    required this.pcnNumber,
    required this.date,
    required this.note,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      pcnNumber: json['pcn'],
      date: json['date'],
      note: json['notes'],
    );
  }
}

class Toll {
  final String name;
  final String id;
  final String date;
  final String note;

  Toll({
    required this.name,
    required this.id,
    required this.date,
    required this.note,
  });

  factory Toll.fromJson(Map<String, dynamic> json) {
    return Toll(
      name: json['name'],
      id: json['pd'],
      date: json['date'],
      note: json['notes'],
    );
  }
}

class Charge {
  final String name;
  final String id;
  final String date;
  final String note;

  Charge({
    required this.name,
    required this.id,
    required this.date,
    required this.note,
  });

  factory Charge.fromJson(Map<String, dynamic> json) {
    return Charge(
      name: json['name'],
      id: json['cd'],
      date: json['date'],
      note: json['notes'],
    );
  }
}
