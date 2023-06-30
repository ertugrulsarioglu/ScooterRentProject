import 'package:flutter/material.dart';

import 'package:scooter_app/screens/forgot_password_page.dart';
import 'package:scooter_app/screens/home_page.dart';
import 'package:scooter_app/screens/taslak_page.dart';
import 'package:scooter_app/screens/login_page.dart';
import 'package:scooter_app/screens/profile_page.dart';
import 'package:scooter_app/screens/profile_settings_page.dart';
import 'package:scooter_app/screens/refresh_password_page.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
