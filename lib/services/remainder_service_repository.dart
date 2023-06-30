import 'dart:io';
import 'package:scooter_app/services/base_service_repository.dart';
import 'package:http/http.dart' as http;
import '../models/remainder.dart';

class RemainderServiceRepository extends BaseServiceRepository {
  final String _controller = "Remainder";
  RemainderServiceRepository(http.Client client) : super(client);

  Future<bool> addRemainder(Remainder model) async {
    try {
      final response = await post("$_controller/AddRemainder", model);
      if (response.statusCode == HttpStatus.ok) return true;
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<double> getRemainder(String userId) async {
    try {
      final response =
          await get("$_controller/GetUserRemainder?userId=$userId");
      if (response.statusCode == HttpStatus.ok)
        return double.parse(response.body);
      return 0;
    } catch (e) {
      throw Exception(e);
    }
  }
}
