class Remainder {
  String? id;
  DateTime? createdDate;
  String? userId;
  double? amount;
  int? remainderType;

  Remainder(
      {this.id,
      this.createdDate,
      this.userId,
      this.amount,
      this.remainderType});

  Remainder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = createdDate;
    userId = json['userId'];
    amount = double.parse(json['amount']);
    remainderType = json['remainderType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdDate'] = createdDate?.toIso8601String();
    data['userId'] = userId;
    data['amount'] = amount;
    data['remainderType'] = remainderType;
    return data;
  }
}
