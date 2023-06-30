import 'dart:convert';

import 'package:scooter_app/extensions/date_time_extension.dart';

List<Scooter> listFromJson(String str) =>
    List<Scooter>.from(json.decode(str).map((x) => Scooter.fromJson(x)));

class Scooter {
  String id;
  String city;
  String district;
  DateTime createdDate;
  String name;
  double lat;
  double lang;
  int state;
  int range;
  DateTime lastSyncDate;
  int chargeState;
  double rentPrice;

  Scooter({
    required this.id,
    required this.createdDate,
    required this.name,
    required this.lat,
    required this.lang,
    required this.state,
    required this.lastSyncDate,
    required this.rentPrice,
    required this.chargeState,
    required this.city,
    required this.district,
    required this.range,
  });

  factory Scooter.fromJson(Map<String, dynamic> json) {
    return Scooter(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      name: json['name'],
      lat: json['lat'].toDouble(),
      lang: json['lang'].toDouble(),
      state: json['state'],
      lastSyncDate: DateTime.parse(json['lastSenkronDate']),
      chargeState: json['chargeState'],
      rentPrice: json['rentPrice'].toDouble(),
      city: json['city'],
      district: json['district'],
      range: json['range'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'CreatedDate': createdDate.toLongDateTime(),
      'Name': name,
      'Lat': lat,
      'Lang': lang,
      'State': state,
      'LastSenkronDate': lastSyncDate.toLongDateTime(),
      'ChargeState': chargeState,
      'City': city,
      'District': district,
      'Range': range,
    };
  }
}
