import 'package:flutter/material.dart';
// import 'package:scooter_app/screens/AdminsScreens/admin_home_page.dart';
import 'package:scooter_app/screens/forgot_password_page.dart';
import 'package:scooter_app/screens/home_page.dart';
import 'package:scooter_app/screens/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:scooter_app/services/login_service_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final t1 = TextEditingController();
  final t2 = TextEditingController();
  bool _isObsecure = true;
  final loginService = LoginServiceRepository(http.Client());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
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
                                  loginService.login(t1.text, t2.text).then(
                                        (value) => {
                                          if (value.role == 1 &&
                                              (value.id?.isNotEmpty ?? false))
                                            {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage()),
                                              )
                                            }
                                          else
                                            {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  elevation: 0,
                                                  content: const Text(
                                                      "Giriş Hatalı"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child:
                                                          const Text("Kapat"),
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            },
                                        },
                                      );
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 140,
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
                          ],
                        ),
                      ),
                      customSizedBox(),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
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
