import 'dart:convert';

class TollsDataClass {
  final bool status;
  final String message;
  final List<Toll> tolls;

  TollsDataClass({
    required this.status,
    required this.message,
    required this.tolls,
  });

  factory TollsDataClass.fromJson(Map<String, dynamic> json) {
    final List<dynamic> tollsList = json['tolls'] ?? [];
    final List<Toll> parsedTolls = tollsList.map((tollJson) {
      return Toll.fromJson(tollJson as Map<String, dynamic>);
    }).toList();

    return TollsDataClass(
      status: json['status'] as bool,
      message: json['message'] as String,
      tolls: parsedTolls,
    );
  }
}

class Toll {
  final int id;
  final String name;
   String? note;
   bool? ischecked;
  final List<String> days; // Change the type to List<String>
  final String price;

  final String createdAt;
  final String updatedAt;

  Toll(  {
    required this.id,
    required this.name,
    required this.days,
    required this.price,
    this.note,
    this.ischecked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Toll.fromJson(Map<String, dynamic> json) {
    final String daysString = json['days'] as String;
    final List<String> parsedDays = jsonDecode(daysString).cast<String>();

    return Toll(
      id: json['id'] as int,
      name: json['name'] as String,
      days: parsedDays,
      price: json['price'] as String,

      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}

