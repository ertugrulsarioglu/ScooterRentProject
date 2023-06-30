import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:scooter_app/models/user.dart';
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
  final t7 = TextEditingController();
  final t8 = TextEditingController();
  final userService = UserServiceRepository(http.Client());
  bool _isObsecure = true;
  bool _isObsecure2 = true;

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
                      decoration: customInputDecoration("Ad"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t7,
                      decoration: customInputDecoration("Soyad"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t8,
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
                              t6.text.isEmpty ||
                              t8.text.isEmpty ||
                              t7.text.isEmpty) {
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
                            userService
                                .register(User(
                                    id: "",
                                    firstName: t1.text,
                                    lastName: t7.text,
                                    username: t8.text,
                                    role: 1,
                                    phoneNumber: t5.text,
                                    email: t4.text,
                                    address: t6.text,
                                    password: t2.text,
                                    createdDate: DateTime.now(),
                                    lastLogindDate: DateTime(0001, 01, 01)))
                                .then((value) {
                              if (value) {
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
                                t1.text = "";
                                t2.text = "";
                                t3.text = "";
                                t4.text = "";
                                t5.text = "";
                                t6.text = "";
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
