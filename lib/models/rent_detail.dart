class RentDetail {
  String? id;
  DateTime? createdDate;
  String? userId;
  String? scooterId;
  DateTime? startDate;
  DateTime? endDate;
  double? startLat;
  double? startLang;
  double? endLat;
  double? endLang;

  RentDetail(
      {this.id,
      this.createdDate,
      this.userId,
      this.scooterId,
      this.startDate,
      this.endDate,
      this.startLat,
      this.startLang,
      this.endLat,
      this.endLang});

  RentDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    scooterId = json['scooterId'];
    createdDate =
        DateTime.parse(json['createdDate']).add(const Duration(hours: 3));
    startDate = DateTime.parse(json['startDate']).add(const Duration(hours: 3));
    endDate = DateTime.parse(json['endDate']).add(const Duration(hours: 3));
    startLat = json['startLat'];
    startLang = json['startLang'];
    endLat = json['endLat'];
    endLang = json['endLang'] as double;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['scooterId'] = scooterId;
    data['createdDate'] = createdDate?.toIso8601String();
    data['startDate'] = startDate?.toIso8601String();
    data['endDate'] = endDate?.toIso8601String();
    data['startLat'] = startLat;
    data['startLang'] = startLang;
    data['endLat'] = endLat;
    data['endLang'] = endLang;
    return data;
  }
}
