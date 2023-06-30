import 'dart:convert';

import 'package:scooter_app/extensions/date_time_extension.dart';

List<Transaction> listFromJson(String str) => List<Transaction>.from(
    json.decode(str).map((x) => Transaction.fromJson(x)));

class Transaction {
  String? id;
  DateTime? createdDate;
  String? userId;
  String? description;
  int? transactionType;

  Transaction({
    this.id,
    this.createdDate,
    this.userId,
    this.description,
    this.transactionType,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      createdDate:
          DateTime.parse(json['createdDate']).add(const Duration(hours: 3)),
      userId: json['userId'],
      description: json['description'],
      transactionType: json['transactionType'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate!.toLongDateTime(),
      'userId': userId,
      'description': description,
      'transactionType': transactionType,
    };
  }
}
