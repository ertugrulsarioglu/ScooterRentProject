import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:scooter_app/services/user_service_repository.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final t1 = TextEditingController();
  final t2 = TextEditingController();
  final t3 = TextEditingController();
  final t4 = TextEditingController();
  final t5 = TextEditingController();
  final t6 = TextEditingController();

  bool _isObsecure = true;
  bool _isObsecure2 = true;

  //database a bağlanma
  // Future<void> register(BuildContext context, String username, String password,
  //     String email, String phone, String adress) async {
  //   try {
  //     final url = Uri.parse("https://localhost:7027/api/User/register");
  //     final Map<String, dynamic> data = {
  //       'username': t1.text,
  //       'password': t2.text,
  //       'email': t4.text,
  //       'phone': t5.text,
  //       'adress': t6.text
  //     };
  //     final requestBody = json.encode(data);
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         "Content-Type": "application/json; charset=UTF-8",
  //       },
  //       body: requestBody,
  //     );
  //     if (response.statusCode == 200) {
  //       print("istek başarılı");
  //     } else {
  //       print("Hata kodu : ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
                      "KAYIT",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t1,
                      decoration: customInputDecoration("Kullanıcı Adı"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t2,
                      decoration:
                          customInputDecoration("Şifre (en az 8 karakter)")
                              .copyWith(
                                  suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObsecure = !_isObsecure;
                          });
                        },
                        icon: Icon(_isObsecure
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                      obscureText: _isObsecure,
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t3,
                      decoration: customInputDecoration(
                              "Şifre tekrar (en az 8 karakter)")
                          .copyWith(
                              suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObsecure2 = !_isObsecure2;
                          });
                        },
                        icon: Icon(_isObsecure2
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                      obscureText: _isObsecure2,
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t4,
                      keyboardType: TextInputType.emailAddress,
                      decoration: customInputDecoration("Email"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t5,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration: customInputDecoration("Telefon"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t6,
                      decoration: customInputDecoration("Adres"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (t1.text.isEmpty ||
                              t2.text.isEmpty ||
                              t3.text.isEmpty ||
                              t4.text.isEmpty ||
                              t5.text.isEmpty ||
                              t6.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content: const Text(
                                    "boş bıraklan yerleri lütfen doldurunuz."),
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
                          } else if (t2.text != t3.text) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content:
                                    const Text("girilen şifre aynı değil !!"),
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
                          } else if (t2.text.length < 8 || t3.text.length < 8) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content: const Text(
                                    "Girilen şifre en az 8 karakter olmalıdır"),
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
                          } else {
                            var userService =
                                UserServiceRepository(http.Client());
                            userService.register(
                                t1.text, t2.text, t4.text, t5.text, t6.text);
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content: const Text("Kayıt Başarılı"),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("Kapat"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                  ),
                                ],
                              ),
                            );
                          }

                          t1.text = "";
                          t2.text = "";
                          t3.text = "";
                          t4.text = "";
                          t5.text = "";
                          t6.text = "";
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
                              "Kayıt Ol",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
