import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scooter_app/extensions/date_time_extension.dart';
import 'package:scooter_app/screens/profile_settings_page.dart';
import '../services/login_service_repository.dart';
import '../models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LoginServiceRepository userService = LoginServiceRepository(http.Client());
  late Future<User> user;
  @override
  void initState() {
    super.initState();
    user = userService.getUser();
  }

  void onDoubleTap() {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return const ProfileSettingsPage();
    })).then((value) {
      if (value == true) {
        setState(() {
          user = userService.getUser();
        });
      }
    });
  }

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
            FutureBuilder<User>(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data;
                  return Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProfileAvatar(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-UABw6y78UKp-MUjYdXCa4nZhTCpLs65ipg&usqp=CAU",
                            borderWidth: 4.0,
                            radius: 60.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Bilgileri güncellemek için çift tıklayınız.'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            onDoubleTap: onDoubleTap,
                            child: Text(
                              "${user!.firstName} ${user.lastName}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            "Müşteri",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          ListView(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Kullanıcı Adı değiştirilemez !'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: CardItem(
                                    icon: Icons.person,
                                    title: "Kullanıcı Adı",
                                    content: "${user.username}",
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Bilgileri güncellemek için çift tıklayınız.'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                onDoubleTap: onDoubleTap,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: CardItem(
                                    icon: Icons.phone,
                                    title: "Telefon",
                                    content: "${user.phoneNumber}",
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Bilgileri güncellemek için çift tıklayınız.'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                onDoubleTap: onDoubleTap,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: CardItem(
                                    icon: Icons.mail_outline,
                                    title: "E-Posta",
                                    content: "${user.email}",
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Bilgileri güncellemek için çift tıklayınız.'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                onDoubleTap: onDoubleTap,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: CardItem(
                                    icon: Icons.location_on_outlined,
                                    title: "Adres",
                                    content: "${user.address}",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: CardItem(
                                  icon: Icons.online_prediction,
                                  title: "Son Giriş",
                                  content: user.lastLogindDate.toLongDateTime(),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: CardItem(
                                  icon: Icons.access_time,
                                  title: "Katılım Tarihi",
                                  content: user.createdDate.toLongDateTime(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text('An error occurred');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
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
