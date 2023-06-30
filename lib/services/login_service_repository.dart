import 'dart:convert';
import 'package:kartal/kartal.dart';
import 'package:scooter_app/services/base_service_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LoginServiceRepository extends BaseServiceRepository {
  final String _controller = "Auth";
  LoginServiceRepository(http.Client client) : super(client);

  Future<void> saveUser(String user) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("user").isNotNullOrNoEmpty) prefs.remove("user");
    await prefs.setString("user", user);
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString("user") ?? "";
    return User.fromJson(jsonDecode(userJson));
  }

  Future<User> login(String username, String password) async {
    try {
      final Map<String, String> data = {
        'username': username,
        'password': password,
      };
      final response = await post("$_controller/login", data);
      if (response.statusCode == 200) {
        await saveUser(response.body);
        final user = User.fromJson(jsonDecode(response.body));
        return user;
      } else {
        return User();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
