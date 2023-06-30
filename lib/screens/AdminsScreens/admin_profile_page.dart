import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:scooter_app/screens/AdminsScreens/admin_transaction_history_page.dart';
import 'package:scooter_app/screens/home_page.dart';
import 'package:scooter_app/screens/profile_settings_page.dart';
import 'package:scooter_app/screens/remainder_page.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF713cd0),
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Stack(
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
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProfileAvatar(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-UABw6y78UKp-MUjYdXCa4nZhTCpLs65ipg&usqp=CAU",
                      borderWidth: 4.0,
                      radius: 60.0,
                    ),
                    const Text(
                      "Argekip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Yönetici",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0), // Her öğe için dikey boşluk ekledik
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: CardItem(
                            icon: Icons.person,
                            title: "Kullanıcı Adı",
                            content: "argekip",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'İşlem detayını görmek için çift tıklayınız.'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          onDoubleTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminTransactionHistoryPage()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: CardItem(
                              icon: Icons.attach_money_rounded,
                              title: "Kasa",
                              content: "150₺",
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: CardItem(
                            icon: Icons.phone,
                            title: "Telefon",
                            content: "0850-303-4791",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: CardItem(
                            icon: Icons.mail_outline,
                            title: "E-Posta",
                            content: "argekip@gmail.com",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: CardItem(
                            icon: Icons.location_on_outlined,
                            title: "Adres",
                            content: "Erzurum/Palandöken",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: CardItem(
                            icon: Icons.online_prediction,
                            title: "Son Giriş",
                            content: "18 Ağustos 2022",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: CardItem(
                            icon: Icons.access_time,
                            title: "Katılım Tarihi",
                            content: "5 Ağustos 2022",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const CardItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(
                width: 24.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customSizedBox() => const SizedBox(
      height: 10,
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
