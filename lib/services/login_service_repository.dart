import 'dart:convert';

import 'package:scooter_app/services/base_service_repository.dart';

import 'package:http/http.dart' as http;

class LoginServiceRepository extends BaseServiceRepository {
  final http.Client _httpClient;
  final String _controller = "User";
  LoginServiceRepository(this._httpClient);

  Future<bool> Login(String username, String password) async {
    try {
      final url = Uri.parse("${baseUrl}/${_controller}/Login");
      final Map<String, String> data = {
        'username': username,
        'password': password,
      };
      final requestBody = json.encode(data);
      final response = await _httpClient.post(
        url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: requestBody,
      );
      if (response.statusCode == 200) {
        print("İstek başarılı.");
        return true;
      } else {
        print("Hata kodu : ${response.body}");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
Future<String> checkEmail(String email) async {
    try {
      final url = Uri.parse("${baseUrl}/${_controller}/CheckEmail?email=${email}");
      final Map<String, String> data = {
        'email': email,
              };
      final response = await _httpClient.post(
        url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
      );
      if (response.statusCode == 200) {
        print("İstek başarılı.");
        return response.body;
      } else {
        print("Hata Mesajı : ${response.body}");
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }


}
