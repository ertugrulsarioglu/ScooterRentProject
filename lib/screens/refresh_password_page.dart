import 'package:flutter/material.dart';
import 'package:scooter_app/screens/login_page.dart';
import 'package:scooter_app/services/user_service_repository.dart';
import 'package:http/http.dart' as http;

class RefreshPasswordPage extends StatefulWidget {
  RefreshPasswordPage({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<RefreshPasswordPage> createState() => _RefreshPasswordPageState();
}

class _RefreshPasswordPageState extends State<RefreshPasswordPage> {
  final t1 = TextEditingController();
  final t2 = TextEditingController();

  bool _isObsecure = true;
  bool _isObsecure2 = true;

  late UserServiceRepository userService;
  @override
  void initState() {
    super.initState();
    userService = UserServiceRepository(http.Client());
  }

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
                      "Şifre \nYenile",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    customSizedBox(),
                    TextField(
                      controller: t1,
                      decoration: customInputDecoration(
                              "Yeni şifrenizi girin (en az 8 karakter)")
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
                      controller: t2,
                      decoration: customInputDecoration(
                              "Yeni şifrenizi tekrar girin (en az 8 karakter)")
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
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (t1.text.isEmpty || t2.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content:
                                    const Text("Alanlar boş bırakılamaz !"),
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
                          } else if (t1.text != t2.text) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content: const Text(
                                    "Girilen şifre tekrarıyla aynı değil !"),
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
                          } else if (t1.text.length < 8 || t2.text.length < 8) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content: const Text(
                                    "Yeni şifre en az 8 karakter olmalıdır."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("Kapat"),
                                    onPressed: () {
                                      t1.text = "";
                                      t2.text = "";
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else if (t1.text == t2.text) {
                            userService
                                .updatePassword(widget.userId, t1.text)
                                .then((value) => {
                                      if (value)
                                        {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              elevation: 0,
                                              content: const Text(
                                                  "Şifre başarıyla değiştirildi."),
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
                              "Şifremi Güncelle",
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
