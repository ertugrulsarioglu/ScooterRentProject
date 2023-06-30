// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
//import 'package:scooter_app/screens/profile_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../models/user.dart';
import '../services/login_service_repository.dart';
import '../services/user_service_repository.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  LoginServiceRepository userService1 = LoginServiceRepository(http.Client());
  UserServiceRepository userService2 = UserServiceRepository(http.Client());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  bool isObsecurePassword = true;
  File? _selectedFile;
  final String profilePhotoKey = 'profile_photo';
  bool isMounted = false;
  @override
  void initState() {
    super.initState();
    _loadProfilePhoto();

    _fillField();
  }

  _fillField() async {
    final user = await userService1.getUser();
    nameController.text = "${user.firstName} ${user.lastName}";
    emailController.text = "${user.email}";
    passwordController.text = "${user.password}";
    phoneController.text = "${user.phoneNumber}";
    addressController.text = "${user.address}";
    setState(() {});
  }

  void _loadProfilePhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? profilePhotoPath = prefs.getString(profilePhotoKey);
    if (profilePhotoPath != null) {
      setState(() {
        _selectedFile = File(profilePhotoPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0xff21254A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF713cd0),
          title: const Text('Profil Ayarlar'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
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
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 12,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: _selectedFile != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(_selectedFile!),
                                          )
                                        : const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-UABw6y78UKp-MUjYdXCa4nZhTCpLs65ipg&usqp=CAU")),
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
                        controller: nameController,
                        decoration: customInputDecoration("İsim Soyisim"),
                        style: const TextStyle(color: Colors.white),
                      ),
                      customSizedBox(),
                      TextField(
                        controller: emailController,
                        decoration: customInputDecoration("Eposta"),
                        style: const TextStyle(color: Colors.white),
                      ),
                      customSizedBox(),
                      TextField(
                        controller: passwordController,
                        decoration: customInputDecoration("Şifre").copyWith(
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
                        controller: phoneController,
                        decoration: customInputDecoration("Telefon"),
                        style: const TextStyle(color: Colors.white),
                      ),
                      customSizedBox(),
                      TextField(
                        controller: addressController,
                        decoration: customInputDecoration("Adres"),
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
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          "Vazgeç",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final user = await userService1.getUser();
                          user.firstName = nameController.text.split(" ").first;
                          user.lastName = nameController.text.split(" ")[1];
                          user.password = passwordController.text;
                          user.phoneNumber = phoneController.text;
                          user.email = emailController.text;
                          user.address = addressController.text;
                          userService2.update(user).then((value) {
                            userService1.saveUser(jsonEncode(value));
                          });
                        },
                        child: const Text(
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
                          padding: const EdgeInsets.symmetric(horizontal: 50),
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
        ));
  }

  void _showSelectionPhoto(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text("Galeriden Fotoğraf Seç"),
              onTap: () {
                _selectUpload(ImageSource.gallery);
              },
            ),
            ListTile(
              title: const Text("Kameradan Fotoğraf Çek"),
              onTap: () {
                _selectUpload(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectUpload(ImageSource source) async {
    final picker = ImagePicker();
    final chosen = await picker.pickImage(source: source);
    setState(() {
      if (chosen != null) {
        // _selectedFile = File(chosen.path);
        _photoCut(File(chosen.path));
      }
    });
    Navigator.pop(context);
  }

  void _photoCut(File photo) async {
    var croppedPhoto = await ImageCropper.platform.cropImage(
      sourcePath: photo.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 800,
    );

    if (croppedPhoto != null) {
      File croppedFile = File(croppedPhoto.path);
      setState(() {
        _selectedFile = croppedFile;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(profilePhotoKey, _selectedFile!.path);
    }
  }
}

Widget customSizedBox() => const SizedBox(
      height: 20,
    );

InputDecoration customInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.white),
    contentPadding: const EdgeInsets.only(bottom: 5),
    floatingLabelBehavior: FloatingLabelBehavior.always,
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
