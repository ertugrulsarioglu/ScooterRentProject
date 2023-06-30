import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scooter_app/screens/refresh_password_page.dart';
import '../services/user_service_repository.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final t1 = TextEditingController();
  final userService = UserServiceRepository(http.Client());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff21254A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * .265,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/topImage.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Şifremi \nUnuttum",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t1,
                      decoration: customInputDecoration("E-Posta girin"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (t1.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content: const Text(
                                    "Lütfen geçerli bir e-posta girin !"),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("Kapat"),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                            return;
                          }
                          userService.checkEmail(t1.text).then((value) {
                            if (value.id?.isEmpty ?? true) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  elevation: 0,
                                  content: const Text("Kullanıcı bulunamadı !"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Kapat"),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RefreshPasswordPage(user: value)),
                            );
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff31274F),
                          ),
                          child: const Center(
                            child: Text(
                              "Şifre yenile",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
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
