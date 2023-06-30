import 'dart:convert';
import 'dart:io';
import 'package:kartal/kartal.dart';
import 'package:scooter_app/services/base_service_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rent_detail.dart';

class RentServiceRepository extends BaseServiceRepository {
  final String _controller = "RentDetail";
  RentServiceRepository(http.Client client) : super(client);

  Future<void> saveRentDetail(String rent) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("rentDetail").isNotNullOrNoEmpty) {
      prefs.remove("rentDetail");
    }
    await prefs.setString("rentDetail", rent);
  }

  Future<RentDetail> getRentDetail() async {
    final prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString("rentDetail") ?? "";
    return RentDetail.fromJson(jsonDecode(userJson));
  }

  Future<void> removeRentDetail() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("rentDetail");
  }

  Future<String> addRentDetail(RentDetail model) async {
    try {
      final response = await post("$_controller/AddRentDetail", model);
      if (response.statusCode == HttpStatus.ok) {
        await saveRentDetail(response.body);
        return "";
      }
      return response.body;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> updateRentDetail(RentDetail model) async {
    try {
      final response = await post("$_controller/UpdateRentDetail", model);
      if (response.statusCode == HttpStatus.ok) {
        removeRentDetail();
        return response.body;
      }
      return response.body;
    } catch (e) {
      throw Exception(e);
    }
  }
}
