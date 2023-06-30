import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:scooter_app/screens/profile_page.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool isObsecurePassword = true;

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
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfilePage()));
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(Icons.settings),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 12,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://i.pravatar.cc/300"),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Colors.white,
                                    ),
                                    color: Colors.purple.shade800,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
              customSizedBox(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [
                    TextField(
                      decoration: customInputDecoration(
                          "Ertuğrul Sarı", "İsim Soyisim"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      decoration: customInputDecoration(
                          "sariertugrull@gmail.com", "Eposta"),
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      decoration: customInputDecoration("*********", "Şifre")
                          .copyWith(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObsecurePassword = !isObsecurePassword;
                                    });
                                  },
                                  icon: Icon(isObsecurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                      obscureText: isObsecurePassword,
                      style: const TextStyle(color: Colors.white),
                    ),
                    customSizedBox(),
                    TextField(
                      decoration: customInputDecoration("Rize", "Adres"),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Vazgeç",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Kaydet",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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
}

Widget customSizedBox() => const SizedBox(
      height: 20,
    );

InputDecoration customInputDecoration(String hintText, String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.white),
    contentPadding: const EdgeInsets.only(bottom: 5),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: hintText,
    hintStyle: const TextStyle(
        color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
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
