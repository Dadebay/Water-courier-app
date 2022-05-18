// ignore_for_file: file_names, deprecated_member_use

import 'package:akar_suw_2/components/ProductProfilText.dart';
import 'package:akar_suw_2/components/button.dart';
import 'package:akar_suw_2/components/widgets.dart';
import 'package:akar_suw_2/controllers/HomePageController.dart';
import 'package:akar_suw_2/models/UserSignInModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/constants.dart';

class ProductProfil extends StatelessWidget {
  ProductProfil({super.key, required this.index, required this.location, required this.comment, required this.phone, required this.quantity, required this.acceptedTime, required this.orderID, required this.removeButtons});
  final bool removeButtons;
  final String acceptedTime;
  final String comment;
  final int index;
  final String location;
  final int orderID;
  final String phone;
  final String quantity;

  Widget bottomSheet(Size size) {
    return Wrap(
      children: [
        Row(
          children: [
            button(
                name: "submit",
                color: Colors.green,
                onTap: () {
                  onTapFunction(3, 4, Colors.green);
                },
                size: size),
            SizedBox(
              width: size.width * 0.02,
            ),
            button(
                name: "call",
                color: Colors.green,
                onTap: () {
                  launch("tel://$phone");
                },
                size: size),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.width >= 800 ? 15 : 0),
          child: Row(
            children: [
              button(
                  name: "noNeed",
                  color: Colors.red,
                  onTap: () {
                    onTapFunction(5, 3, Colors.red);
                  },
                  size: size),
              SizedBox(
                width: size.width * 0.02,
              ),
              button(
                  name: "cannotComeToday",
                  color: Colors.red,
                  onTap: () {
                    onTapFunction(6, 2, Colors.red);
                  },
                  size: size),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: size.width >= 800 ? 15 : 0),
          child: Row(
            children: [
              button(
                  name: "Ýalňyş",
                  color: Colors.red,
                  onTap: () {
                    onTapFunction(8, 1, Colors.red);
                  },
                  size: size),
              SizedBox(
                width: size.width * 0.02,
              ),
              button(
                  name: "noHome",
                  color: Colors.red,
                  onTap: () {
                    onTapFunction(4, 0, Colors.red);
                  },
                  size: size),
            ],
          ),
        ),
      ],
    );
  }

  List titles = [
    "noHome".tr,
    "error".tr,
    "cannotComeToday".tr,
    "noNeed".tr,
    "submit".tr,
  ];
  List subTitles = [
    "noHomesubtitle".tr,
    "errorSubtitle".tr,
    "cannotComeTodaySubtitle".tr,
    "noNeedSubtitle".tr,
    "submitSubtitle",
  ];
  onTapFunction(int index, int title, Color color) {
    Get.find<HomePageController>().list.removeWhere((element) => element["id"] == orderID);
    OrderModel().accepted(body: {"status_id": index}, id: orderID);

    Get.back();
    showSnackBar(titles[title], subTitles[title], color);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              size: size.width >= 800 ? size.width * 0.035 : size.width * 0.05,
              color: Colors.black,
            )),
        title: Text(
          "order".tr + " $index",
          style: TextStyle(fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? size.width * 0.03 : size.width * 0.045, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextPart(size: size, icon: IconlyBold.location, text: "address", text2: location, variant: false),
            comment != "" ? TextPart(size: size, icon: IconlyBold.chat, text: "comment", text2: comment, variant: false) : const SizedBox.shrink(),
            TextPart(size: size, icon: IconlyBold.call, text: "phoneNumber", text2: phone, variant: true),
            TextPart(size: size, icon: IconlyBold.timeCircle, text: "arrivedTime", text2: acceptedTime, variant: true),
            TextPart(size: size, icon: IconlyBold.edit, text: "count", text2: quantity, variant: true),
          ],
        ),
      ),
      bottomSheet: removeButtons == false
          ? Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                top: size.width * 0.01,
                left: size.width * 0.02,
                right: size.width * 0.02,
              ),
              child: bottomSheet(size),
            )
          : const SizedBox.shrink(),
    );
  }
}
