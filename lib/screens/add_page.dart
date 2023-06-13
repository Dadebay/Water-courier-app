import 'dart:math';

import 'package:akar_suw_2/components/agree_button_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../components/constants.dart';
import '../components/custom_text_field.dart';
import '../components/widgets.dart';
import '../controllers/HomePageController.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  FocusNode node1 = FocusNode();
  FocusNode node2 = FocusNode();
  FocusNode node3 = FocusNode();
  FocusNode node4 = FocusNode();
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Gosmak ".tr,
            style: TextStyle(fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.05, color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            CustomTextField(labelName: 'Phone number', controller: textEditingController1, focusNode: node1, requestfocusNode: node2, isNumber: true, unFocus: false, icon: IconlyLight.call),
            CustomTextField(labelName: 'Location', controller: textEditingController2, focusNode: node2, requestfocusNode: node3, isNumber: false, unFocus: false, icon: IconlyLight.location),
            CustomTextField(labelName: 'Quantity', controller: textEditingController3, focusNode: node3, requestfocusNode: node4, isNumber: true, unFocus: false, icon: CupertinoIcons.add_circled),
            CustomTextField(labelName: 'Comment', controller: textEditingController4, focusNode: node4, requestfocusNode: node1, isNumber: false, unFocus: false, icon: IconlyLight.message),
            const SizedBox(
              height: 50,
            ),
            AgreeButton(
                onTap: () {
                  Random rand = Random();
                  int id = homePageController.list.length + 1;
                  int statusId = rand.nextInt(3);
                  homePageController.list.add({
                    "id": id,
                    "location": textEditingController2.text,
                    "phone": textEditingController1.text,
                    "quantity": textEditingController3.text,
                    "status_id": statusId,
                    "accepted_time": DateTime.now().toString(),
                    "comment": textEditingController4.text,
                  });
                  showSnackBar('Gosuldy', 'Sargyt gosuldy', Colors.green);
                },
                name: 'Gos',
                style: false)
          ],
        ),
      ),
    );
  }
}
