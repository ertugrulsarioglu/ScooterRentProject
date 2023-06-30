import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:scooter_app/services/base_service_repository.dart';
import '../models/user.dart';

class UserServiceRepository extends BaseServiceRepository {
  final String _controller = "User";
  UserServiceRepository(http.Client client) : super(client);

  Future<bool> register(User user) async {
    try {
      final response = await post("$_controller/AddUser", user);
      response.body;
      return response.statusCode == HttpStatus.ok ? true : false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> update(User user) async {
    try {
      final response = await post("$_controller/UpdateUser", user);
      if (response.statusCode == HttpStatus.ok) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        return User();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> checkEmail(String email) async {
    try {
      final response = await get("$_controller/GetUserByEmail?email=$email");
      if (response.statusCode == HttpStatus.ok) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        return User();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
