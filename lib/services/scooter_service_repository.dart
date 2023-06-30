import 'dart:io';

import 'package:scooter_app/services/base_service_repository.dart';
import 'package:http/http.dart' as http;

import '../models/scooter.dart';

class ScooterServiceRepository extends BaseServiceRepository {
  final String _controller = "Scooter";
  ScooterServiceRepository(http.Client client) : super(client);
  Future<List<Scooter>> getScooter() async {
    try {
      final response = await get("$_controller/GetScooters");
      if (response.statusCode == HttpStatus.ok) {
        return listFromJson(response.body);
      }
      return List.empty();
    } catch (e) {
      throw Exception(e);
    }
  }
}
