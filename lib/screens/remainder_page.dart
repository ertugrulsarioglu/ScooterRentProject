import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scooter_app/models/remainder.dart';
import 'package:scooter_app/services/login_service_repository.dart';
import 'package:scooter_app/services/remainder_service_repository.dart';

class RemainderPage extends StatefulWidget {
  const RemainderPage({Key? key}) : super(key: key);

  @override
  State<RemainderPage> createState() => _RemainderPageState();
}

class _RemainderPageState extends State<RemainderPage> {
  double balance = 0;
  double increaseAmount = 0;
  LoginServiceRepository userService = LoginServiceRepository(http.Client());
  RemainderServiceRepository remainderService =
      RemainderServiceRepository(http.Client());
  final format = NumberFormat("#,##0.00", "en_US");
  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  void loadBalance() {
    userService.getUser().then((value) {
      setState(() {
        remainderService.getRemainder(value.id!).then((value) {
          setState(() {
            balance = value;
          });
        });
      });
    });
  }

  void increaseBalance() {
    setState(() {
      balance += 5;
      increaseAmount += 5;
    });
  }

  void saveBalance() async {
    if (increaseAmount == 0) return;
    final user = await userService.getUser();
    final remainder = Remainder(
        id: "",
        createdDate: DateTime.now(),
        remainderType: 1,
        userId: user.id,
        amount: increaseAmount);
    await remainderService.addRemainder(remainder).then((value) {
      if (value) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            elevation: 0,
            content: const Text("Bakiye Kaydedildi"),
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
        title: const Text("Bakiye"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Bakiye: ${format.format(balance)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: increaseBalance,
                          child: const Text(
                            'Bakiye Yükle',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF713cd0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: saveBalance,
                          child: const Text(
                            'Kaydet',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF713cd0),
                          ),
                        ),
                      ],
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
