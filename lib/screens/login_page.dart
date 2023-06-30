import 'package:flutter/material.dart';
import 'package:scooter_app/screens/forgot_password_page.dart';
import 'package:scooter_app/screens/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:scooter_app/services/login_service_repository.dart';

import 'taslak_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final t1 = TextEditingController();
  final t2 = TextEditingController();
  bool _isObsecure = true;
  late LoginServiceRepository loginService;
  @override
  void initState() {
    super.initState();
    loginService = LoginServiceRepository(http.Client());
  }
  //database a bağlanma ve user karışılaştırma
  // Future<void> login(
  //     BuildContext context, String username, String password) async {
  //   try {
  //     final url = Uri.parse("https://localhost:7027/api/User/login");
  //     final Map<String, dynamic> data = {
  //       'username': t1.text,
  //       'password': t2.text
  //     };
  //     final requestBody = json.encode(data);
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: requestBody,
  //     );
  //     if (response.statusCode == 200) {
  //       Navigator.of(context).push(
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (ctx) => AlertDialog(
  //           elevation: 0,
  //           content: const Text("Giriş Hatalı"),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text("Kapat"),
  //               onPressed: () {
  //                 Navigator.of(ctx).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
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
                      "Giriş \nEkranı",
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
                      decoration: customInputDecoration("Şifre").copyWith(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsecure = !_isObsecure;
                            });
                          },
                          icon: Icon(_isObsecure
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      obscureText: _isObsecure,
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage()),
                          );
                        },
                        child: Text(
                          "Şifremi Unuttum",
                          style: TextStyle(color: Colors.pink[200]),
                        ),
                      ),
                    ),
                    customSizedBox(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (t1.text.isEmpty || t2.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content: const Text(
                                    "Kullanıcı adı ve şifre boş bırakılamaz!"),
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
                          } else if (t2.text.length < 8) {
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
                            loginService.Login(t1.text, t2.text)
                                .then((value) => {
                                      if (value)
                                        {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const taslak()),
                                          )
                                        }
                                      else
                                        {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              elevation: 0,
                                              content:
                                                  const Text("Giriş Hatalı"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text("Kapat"),
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        }
                                    });
                          }
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
                              "Giriş Yap",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    customSizedBox(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: Text(
                          "Hesap Oluştur",
                          style: TextStyle(color: Colors.pink[200]),
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
