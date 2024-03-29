// ignore_for_file: file_names, deprecated_member_use

import 'package:akar_suw_2/components/constants.dart';
import 'package:akar_suw_2/controllers/HomePageController.dart';
import 'package:akar_suw_2/models/UserSignInModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetMine extends StatelessWidget {
  BottomSheetMine({Key? key}) : super(key: key);
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(
        size.width >= 800 ? size.width * 0.01 : size.width * 0.024,
      ),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    OrderModel().getOrders();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: Text(
                    "${'submitted'.tr}  ${Get.find<HomePageController>().acceptedNumber}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: normsProSemiBold,
                      fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.04,
                    ),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    homePageController.list.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: Text(
                    "${'left'.tr}  ${Get.find<HomePageController>().leftNumber}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: normsProSemiBold,
                      fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.04,
                    ),
                  )),
            ),
          ],
        );
      }),
    );
  }
}
