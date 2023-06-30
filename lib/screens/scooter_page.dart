import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import '../models/scooter.dart';
import '../services/login_service_repository.dart';
import '../services/remainder_service_repository.dart';
import '../services/scooter_service_repository.dart';

class ScooterPage extends StatefulWidget {
  const ScooterPage({Key? key}) : super(key: key);

  @override
  State<ScooterPage> createState() => _ScooterPageState();
}

class _ScooterPageState extends State<ScooterPage> {
  final scooterService = ScooterServiceRepository(http.Client());
  final remainderService = RemainderServiceRepository(http.Client());
  final userService = LoginServiceRepository(http.Client());
  // late List<Scooter> scooters;
  @override
  void initState() {
    super.initState();
  }

  bool checkRemainder() {
    userService.getUser().then((value) {
      remainderService.getRemainder(value.id!).then((value) {
        return value > 0;
      });
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF713cd0),
        title: const Text("Scooterlar"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Scooter>>(
              future: scooterService.getScooter(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return scooterListView(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Veri alınamadı: ${snapshot.error}'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget scooterListView(List<Scooter> scooters) {
    return ListView.builder(
      itemCount: scooters.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            scooters[index].name,
            style: TextStyle(color: Colors.white),
          ),
          //tileColor: Colors.orange,
          leading: const Icon(
            Icons.electric_scooter_outlined,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).pop(scooters[index].id);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        );
      },
    );
  }

  onBarcodeScan(String barcodeScanRes) {
    if (barcodeScanRes != "-1") {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("QR Kodu"),
          content: Text(barcodeScanRes),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Tamam"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> showBarcodeScanner() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Vazgeç", true, ScanMode.QR);
    onBarcodeScan(barcodeScanRes);
  }
}



// class _RecomandedCard extends StatelessWidget {
//   const _RecomandedCard({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//   }) : super(key: key);

//   final String title;
//   final String subtitle;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//             '#FF713cd0', 'Vazgeç', true, ScanMode.QR);

//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Okunan barkod: $barcodeScanRes")),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
//         child: Row(
//           children: [
//             Image.network(
//               "https://e7.pngegg.com/pngimages/376/267/png-clipart-electric-motorcycles-and-scooters-electric-vehicle-electric-bicycle-light-electric-scooter-scooter-bicycle.png",
//               height: 96,
//               errorBuilder: (context, error, stackTrace) => const Placeholder(),
//             ),
//             Expanded(
//               child: ListTile(
//                 title: Text(
//                   title,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 subtitle: Text(
//                   subtitle,
//                   style: const TextStyle(color: Colors.white54),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


 // child: Container(
                  //   decoration:
                  //       BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  //   child: ListView.builder(
                  //     padding: EdgeInsets.zero,
                  //     itemCount: 2,
                  //     shrinkWrap: true,
                  //     physics: const ClampingScrollPhysics(),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return _RecomandedCard(
                  //           title: "Xiaomi ${index + 1}",
                  //           subtitle: "Açıklama ${index + 1}");
                  //     },
                  //   ),
                  // ),



                    // Widget customSizedBox() => const SizedBox(
  //       height: 20,
  //     );

  // InputDecoration customInputDecoration(String hintText) {
  //   return InputDecoration(
  //     hintText: hintText,
  //     hintStyle: const TextStyle(color: Colors.grey),
  //     enabledBorder: const UnderlineInputBorder(
  //       borderSide: BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     focusedBorder: const UnderlineInputBorder(
  //       borderSide: BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //   );
  // }