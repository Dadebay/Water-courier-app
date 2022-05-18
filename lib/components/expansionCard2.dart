// ignore_for_file: file_names, must_be_immutable

import 'package:akar_suw_2/models/UserSignInModel.dart';
import 'package:akar_suw_2/screens/ProductProfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import 'constants.dart';

class ExpansionCard2 extends StatelessWidget {
  final int index;
  final OrderModel order;
  ExpansionCard2({
    Key? key,
    required this.index,
    required this.order,
  }) : super(key: key);

  List status = [
    "sumofDay1".tr,
    "sumofDay2".tr,
    "submit".tr,
    "noHome".tr,
    "noNeed".tr,
    "cannotComeToday".tr,
    "error".tr,
  ];
  List color = [
    backgroundColor,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.red,
    Colors.yellow,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      onTap: () {
        Get.to(() => ProductProfil(
              index: index + 1,
              removeButtons: true,
              acceptedTime: "${order.acceptedTime}",
              comment: "${order.commit}",
              location: "${order.location}",
              orderID: order.id!,
              phone: "${order.phone}",
              quantity: "${order.quantity}",
            ));
      },
      title: Text(order.location!, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: size.width >= 800 ? size.width * 0.031 : size.width * 0.036, fontFamily: normsProMedium)),
      contentPadding: EdgeInsets.symmetric(vertical: size.width >= 800 ? 15 : 0),
      subtitle: Text(
        "${status[order.statusId! - 1]}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Colors.grey, fontSize: size.width >= 800 ? size.width * 0.030 : size.width * 0.034, fontFamily: normsProMedium),
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: size.width >= 800 ? size.width * 0.015 : size.width * 0.02,
          right: size.width >= 800 ? size.width * 0.015 : 0,
        ),
        child: CircleAvatar(
          backgroundColor: color[order.statusId! - 1],
          radius: size.width >= 800 ? size.width * 0.03 : size.width * 0.045,
          child: Text(
            "${order.id}",
            style: TextStyle(color: Colors.black, fontSize: size.width >= 800 ? size.width * 0.025 : size.width * 0.04, fontFamily: normsProSemiBold),
          ),
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(
          right: size.width >= 800 ? size.width * 0.02 : size.width * 0.03,
        ),
        child: Icon(
          IconlyLight.arrowRightCircle,
          color: Colors.black,
          size: size.width >= 800 ? size.width * 0.04 : size.width * 0.055,
        ),
      ),
    );
  }
}
