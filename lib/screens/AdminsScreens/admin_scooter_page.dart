import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scooter_app/screens/home_page.dart';
import 'package:scooter_app/screens/profile_settings_page.dart';
import 'package:scooter_app/screens/refresh_password_page.dart';
import 'package:scooter_app/services/login_service_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AdminScooterPage extends StatefulWidget {
  const AdminScooterPage({Key? key}) : super(key: key);

  @override
  State<AdminScooterPage> createState() => _AdminScooterPageState();
}

class _AdminScooterPageState extends State<AdminScooterPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF713cd0),
        title: const Text("Scooterlar"),
      ),
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
                  child: ListTile(
                    title: const Text(
                      "Xiaomi Elektrikli Scooter",
                      style: TextStyle(color: Colors.white),
                    ),
                    tileColor: Colors.orange,
                    leading: const Icon(
                      Icons.electric_scooter_outlined,
                      color: Colors.white,
                    ),
                    trailing: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          elevation: 0,
                          content: const Text("Scooter Başarıyla silindi"),
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
                    },
                  ),
                ),
              ]),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 160, vertical: 450),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 35,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF713cd0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // onBarcodeScan(String barcodeScanRes) {
  //   if (barcodeScanRes != "-1") {
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: Text("QR Kodu"),
  //         content: Text(barcodeScanRes),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text("Tamam"),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  // Future<void> showBarcodeScanner() async {
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //       "#ff6666", "Vazgeç", true, ScanMode.QR);
  //   onBarcodeScan(barcodeScanRes);
  // }
}
