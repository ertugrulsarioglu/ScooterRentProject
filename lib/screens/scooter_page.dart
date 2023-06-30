import 'package:flutter/material.dart';
import 'package:scooter_app/screens/refresh_password_page.dart';
import 'package:scooter_app/services/login_service_repository.dart';
import 'package:http/http.dart' as http;

class ScooterPage extends StatefulWidget {
  const ScooterPage({Key? key}) : super(key: key);

  @override
  State<ScooterPage> createState() => _ScooterPageState();
}

class _ScooterPageState extends State<ScooterPage> {
  final t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Material(
      color: const Color(0xff21254A),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  height: height * .265,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/topImage.png"),
                    ),
                  ),
                ),
                Positioned(
                  top: 1,
                  left: 10,
                  child: SizedBox(
                    width: 375,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SafeArea(
                          child: Text(
                            "Scooter \nSayfası",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget customSizedBox() => const SizedBox(
        height: 20,
      );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}
