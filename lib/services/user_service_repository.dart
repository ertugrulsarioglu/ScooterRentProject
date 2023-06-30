import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scooter_app/services/base_service_repository.dart';

class UserServiceRepository extends BaseServiceRepository {
  final http.Client _httpClient;
  final String _controller = "User";
  UserServiceRepository(this._httpClient);

  Future<void> register(String username, String password, String email,
      String phone, String address) async {
    try {
      final url = Uri.parse("${baseUrl}/${_controller}/Register");
      final Map<String, String> data = {
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
        'adress': address,
      };
      final requestBody = json.encode(data);
      final response = await _httpClient.post(
        url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: requestBody,
      );
      if (response.statusCode == 200) {
        print("İstek başarılı.");
      } else {
        print("Hata mesajı : ${response.body}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updatePassword(String userId, String password) async {
    try {
      final url = Uri.parse("${baseUrl}/${_controller}/UpdateUserPassword?id=${userId}&password=${password}");
      final response = await _httpClient.post(
        url,
      );
      if (response.statusCode == 200) {
        print("İstek başarılı.");
        return true;
      } else {
        print("Hata mesajı : ${response.body}");
        return false;
      }
    } catch (e) {
      print(e);
        return false;
    }
  }
}
