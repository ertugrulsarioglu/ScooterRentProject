import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseServiceRepository {
  final String _baseUrl = "http://192.168.1.133:90/api";
  final http.Client _httpClient;
  BaseServiceRepository(this._httpClient);

  Future<http.Response> get(String path) async {
    try {
      final url = Uri.parse("$_baseUrl/$path");
      return await _httpClient.get(url);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> post(String path, body) async {
    try {
      final url = Uri.parse("$_baseUrl/$path");
      final requestBody = json.encode(body);
      return await _httpClient.post(
        url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: requestBody,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
