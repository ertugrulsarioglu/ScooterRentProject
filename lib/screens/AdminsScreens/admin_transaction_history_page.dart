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

class AdminTransactionHistoryPage extends StatefulWidget {
  const AdminTransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<AdminTransactionHistoryPage> createState() =>
      _AdminTransactionHistoryPageState();
}

class _AdminTransactionHistoryPageState
    extends State<AdminTransactionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF713cd0),
        title: const Text("İşlem Geçmişi"),
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
                      "Ertuğrul Sarı             100₺",
                      style: TextStyle(color: Colors.white),
                    ),
                    tileColor: Colors.orange,
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          elevation: 0,
                          content: const Text("Kullanıcı Başarıyla silindi"),
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
