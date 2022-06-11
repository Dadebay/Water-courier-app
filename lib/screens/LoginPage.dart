// ignore_for_file: file_names, always_use_package_imports, use_key_in_widget_constructors
import 'package:akar_suw_2/components/constants.dart';
import 'package:akar_suw_2/components/widgets.dart';
import 'package:akar_suw_2/controllers/HomePageController.dart';
import 'package:akar_suw_2/models/UserSignInModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final HomePageController loginController = Get.put(HomePageController());
  TextEditingController controllerLogin1 = TextEditingController();
  TextEditingController controllerLogin2 = TextEditingController();
  FocusNode focusNodeLogin1 = FocusNode();
  FocusNode focusNodeLogin2 = FocusNode();

  final _form1Key = GlobalKey<FormState>();
  Widget agreeButton(Size size) {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          final storage = GetStorage();
          String file = storage.read("firebase");
          print(file);
          if (storage.read("firebase") == null) {
            showSnackBar("Ýalňyş", "Maglumatlar ýalňyş täzeden snanşyň", Colors.red);
          } else {
            loginController.loginButton.value = true;
            UserSignInModel()
                .login(
              password: controllerLogin2.text,
              phone: controllerLogin1.text,
              fireBaseCode: file,
            )
                .then((value) {
              if (value == true) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
              } else {
                showSnackBar("Ýalňyş", "Maglumatlar ýalňyş täzeden snanşyň", Colors.red);
              }
              loginController.loginButton.value = false;
            });
          }
        },
        child: Center(
          child: PhysicalModel(
            elevation: 4,
            borderRadius: borderRadius10,
            color: kPrimaryColor,
            child: AnimatedContainer(
              decoration: const BoxDecoration(
                borderRadius: borderRadius10,
                color: kPrimaryColor,
              ),
              curve: Curves.decelerate,
              height: loginController.loginButton.value
                  ? size.width >= 800
                      ? 70
                      : 50
                  : size.width >= 800
                      ? 70
                      : 50,
              alignment: Alignment.center,
              width: loginController.loginButton.value
                  ? size.width >= 800
                      ? 120
                      : 70
                  : size.width,
              duration: const Duration(milliseconds: 1000),
              child: loginController.loginButton.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Center(
                      child: Text(
                        "agree".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: size.width >= 800 ? 30 : 22, fontFamily: normsProSemiBold, color: Colors.white),
                      ),
                    ),
            ),
          ),
        ),
      );
    });
  }

  Column namePart(Size size) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              "welcome".tr,
              style: TextStyle(color: Colors.black, fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? 32 : 20),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "welcomeTitle".tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? 28 : 15),
          ),
        ),
      ],
    );
  }

  Widget phoneNumber(Size size) {
    return TextFormField(
      style: TextStyle(fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? 28 : 18, color: Colors.black),
      textInputAction: TextInputAction.next,
      focusNode: focusNodeLogin1,
      controller: controllerLogin1,
      validator: (value) {
        if (value!.isEmpty) {
          return "errorEmpty".tr;
        } else if (value.length != 8) {
          return "errorPhoneCount".tr;
        } else {
          return loginController.loginButton.value == false ? "errorPhoneNumber".tr : null;
        }
      },
      onEditingComplete: () {
        focusNodeLogin2.requestFocus();
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),
      ],
      decoration: InputDecoration(
        errorMaxLines: 3,
        errorStyle: const TextStyle(fontFamily: normsProMedium),
        contentPadding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
        hintText: '+993 62 626262',
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: TextStyle(fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? 28 : 16, color: Colors.grey),
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red.shade200, width: 2), borderRadius: borderRadius10),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor, width: 2), borderRadius: borderRadius10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade100,
            ),
            borderRadius: borderRadius10),
      ),
    );
  }

  Widget textfieldPassword(Size size) {
    return TextFormField(
      style: TextStyle(fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? 28 : 18, color: Colors.black),
      textInputAction: TextInputAction.next,
      controller: controllerLogin2,
      validator: (value) {
        if (value!.isEmpty) {
          return "errorEmpty".tr;
        } else if (value.length < 4) {
          return "errorPasswordCount".tr;
        } else {
          return loginController.loginButton.value == false ? "errorPassword".tr : null;
        }
      },
      obscuringCharacter: "*",
      focusNode: focusNodeLogin2,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      decoration: InputDecoration(
        errorMaxLines: 3,
        errorStyle: const TextStyle(fontFamily: normsProMedium),
        contentPadding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        label: Text("password".tr),
        labelStyle: TextStyle(color: Colors.grey[500], fontSize: size.width >= 800 ? 28 : 18, fontFamily: normsProSemiBold),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red.shade200, width: 2), borderRadius: borderRadius10),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade100), borderRadius: borderRadius10),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor, width: 2), borderRadius: borderRadius10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade100,
            ),
            borderRadius: borderRadius10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(size.height);
    // print(size.width);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: size.height <= 740 ? size.height + 60 : size.height,
          padding: size.width > 750 ? EdgeInsets.symmetric(horizontal: size.width / 5, vertical: 85) : EdgeInsets.symmetric(horizontal: 20, vertical: size.height <= 640 ? 0 : 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.width > 800 ? 50 : 00, bottom: 20, right: 40, left: 40),
                child: FlutterLogo(
                  size: size.width >= 800 ? 300 : 220,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: namePart(size),
              ),
              Form(
                key: _form1Key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    phoneNumber(size),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: textfieldPassword(size),
                    ),
                  ],
                ),
              ),
              agreeButton(size),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
