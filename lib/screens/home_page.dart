// ignore_for_file: use_build_context_synchronously, avoid_unnecessary_containers, sort_child_properties_last, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:scooter_app/models/rent_detail.dart';
import 'package:scooter_app/screens/login_page.dart';
import 'package:scooter_app/screens/profile_page.dart';
import 'package:scooter_app/screens/remainder_page.dart';
import 'package:scooter_app/screens/scooter_page.dart';
import 'package:http/http.dart' as http;
import '../models/scooter.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import '../services/login_service_repository.dart';
import '../services/remainder_service_repository.dart';
import '../services/rent_service_repository.dart';
import '../services/scooter_service_repository.dart';
import '../services/transaction_service_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool kiralamaBitirVisible = false;
  bool scootersButtonVisible = true;
  Timer? _timer;
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(39.90542443068985, 41.26579858957866);
  final Map<String, Marker> _markers = {};
  final scooterService = ScooterServiceRepository(http.Client());
  final transactionService = TransactionServiceRepository(http.Client());
  final remainderService = RemainderServiceRepository(http.Client());
  final userService = LoginServiceRepository(http.Client());
  final rentService = RentServiceRepository(http.Client());
  User? user;
  String kiralaButonTitle = "Kirala";
  // late List<Scooter> scooters;
  @override
  void initState() {
    super.initState();
    setUser();
  }

  Future<void> setUser() async {
    user = await userService.getUser();
  }

  Future<bool> checkRemainder() async {
    final result = await remainderService.getRemainder(user!.id!);
    return result > 0;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // Geri düğmesine basıldığında işlem yapmak için burayı kullanabilirsiniz
        // true döndürerek geri gitmeyi engelleyebilirsiniz
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onTap: (latLng) {
                print(latLng);
              },
              onLongPress: (latLng) {
                print(latLng);
              },
              onCameraMove: (cp) {
                print(cp);
              },
              markers: _markers.values.toSet(),
              onCameraMoveStarted: () {
                print("Başladı");
              },
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 13,
              ),
              onMapCreated: (controller) async {
                _mapController = controller;
                final result = await scooterService.getScooter();
                if (result.isEmpty) return;
                result.forEach((value) => addMarker(value));
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: false,
              indoorViewEnabled: true,
              trafficEnabled: true,
              zoomControlsEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(8, 15),
            ),
            Positioned(
              bottom: 10,
              left: 110,
              right: 110,
              child: Visibility(
                visible: scootersButtonVisible,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScooterPage()),
                      );

                      _mapController.animateCamera(
                        CameraUpdate.newLatLngZoom(
                          LatLng(_markers[result]!.position.latitude, _markers[result]!.position.longitude),
                          15.0,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Icon(Icons.electric_scooter_outlined, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Scooterlar",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                      backgroundColor: const Color(0xff31274F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 110,
              right: 110,
              child: Visibility(
                visible: kiralamaBitirVisible,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: ElevatedButton(
                    onPressed: () {
                      stopMarkerMovement();
                      rentService.getRentDetail().then((value) {
                        value.endLat = _markers[value.scooterId]?.position.latitude;
                        value.endLang = _markers[value.scooterId]?.position.longitude;
                        value.endDate = DateTime.now().add(const Duration(hours: 3));
                        rentService.updateRentDetail(value).then((value) {
                          if (value.isNotNullOrNoEmpty) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                elevation: 0,
                                content: Text(
                                  value,
                                ),
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
                          }
                          setState(() {
                            kiralamaBitirVisible = false;
                            scootersButtonVisible = true;
                            kiralaButonTitle = "Kirala";
                          });
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                      backgroundColor: const Color(0xff31274F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Icon(Icons.electric_scooter_outlined, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Bitir",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF713cd0),
          title: const Text('Harita'),
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<String>(
              onSelected: (choice) {
                if (choice == 'profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                } else if (choice == 'exit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else if (choice == 'remainder') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RemainderPage()),
                  );
                } else if (choice == 'transactionHistory') {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: 1000,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                          color: Color(0xff21254A),
                        ),
                        child: FutureBuilder<List<Transaction>>(
                          future: transactionService.getTransactions(user!.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return transactionListView(snapshot.data!);
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Veri alınamadı: ${snapshot.error}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Profil'),
                ),
                const PopupMenuItem<String>(
                  value: 'remainder',
                  child: Text('Bakiye'),
                ),
                const PopupMenuItem<String>(
                  value: 'transactionHistory',
                  child: Text('İşlem Geçmişi'),
                ),
                const PopupMenuItem<String>(
                  value: 'exit',
                  child: Text('Çıkış Yap'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addMarker(Scooter scooter) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/markerScooter.png',
    );
    var marker = Marker(
      markerId: MarkerId(scooter.id),
      position: LatLng(scooter.lat, scooter.lang),
      infoWindow: InfoWindow(
        title: scooter.name,
        snippet: "Kiralamak için tıklayınız.",
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            builder: (BuildContext context) {
              return Container(
                height: 1000,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                  color: Color(0xff21254A),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 500,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/images/scooterBottomSheet.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Kiralama ücreti kullanım sürenizle ilgilidir.\nSaati: ${scooter.rentPrice} ₺\nTam kapasite menzil: ${scooter.range} KM\nScooter Konum: ${scooter.city}/${scooter.district}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (kiralaButonTitle == "Kullanımda") return;
                        Navigator.pop(context);

                        final isEnougRemainder = await checkRemainder();
                        if (!isEnougRemainder) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              elevation: 0,
                              content:
                                  const Text("Yetersiz bakiye!\nLütfen bakiye yükleyip daha sonra tekrar deneyiniz."),
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
                        }

                        final model = RentDetail(
                            createdDate: DateTime.now(),
                            userId: user?.id,
                            scooterId: scooter.id,
                            startDate: DateTime.now(),
                            endDate: DateTime(0001, 1, 1),
                            startLat: _markers[scooter.id]?.position.latitude,
                            startLang: _markers[scooter.id]?.position.longitude,
                            endLang: double.minPositive,
                            endLat: double.minPositive,
                            id: "");
                        final result = await rentService.addRentDetail(model);
                        if (result.isNotEmpty) {
                          print(result);
                          return;
                        }
                        startMarkerMovement(scooter.id);
                        setState(() {
                          kiralamaBitirVisible = true;
                          scootersButtonVisible = false;
                          kiralaButonTitle = "Kullanımda";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        backgroundColor: const Color(0xFF713cd0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        kiralaButonTitle,
                        style: const TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          );
        },
      ),
      icon: markerIcon,
    );
    _markers[scooter.id] = marker;
    setState(() {});
  }

  void startMarkerMovement(String id) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateMarkerPosition(id);
    });
  }

  void stopMarkerMovement() {
    _timer?.cancel();
  }

  void updateMarkerPosition(String id) {
    double newLatitude = _markers[id]!.position.latitude + 0.0003;
    double newLongitude = _markers[id]!.position.longitude;

    Marker updatedMarker = _markers[id]!.copyWith(
      positionParam: LatLng(newLatitude, newLongitude),
    );

    setState(() {
      _markers[id] = updatedMarker;
    });
  }

  Widget transactionListView(List<Transaction> transactions) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (BuildContext context, int index) {
        final item = transactions[index];
        return ListTile(
          title: Text(
            "${item.description}",
            style: const TextStyle(color: Colors.white),
          ),
          leading: const Icon(
            Icons.star,
            color: Colors.white,
          ),
        );
      },
    );
  }

  // onBarcodeScan(String barcodeScanRes) {
  //   if (barcodeScanRes != "-1") {
  //     startMarkerMovement();
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: const Text("QR Kodu"),
  //         content: Text(barcodeScanRes),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               stopMarkerMovement();
  //               Navigator.pop(context);
  //             },
  //             child: const Text("Tamam"),
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
