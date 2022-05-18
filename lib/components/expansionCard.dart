// ignore_for_file: file_names, must_be_immutable

import 'package:akar_suw_2/screens/ProductProfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import 'constants.dart';

class ExpansionCard extends StatelessWidget {
  final int index;
  final String location;
  final String commit;
  final String acceptedTime;
  final String phone;
  final String quantity;
  final int orderID;
  final int statusID;
  const ExpansionCard({
    Key? key,
    required this.index,
    required this.location,
    required this.commit,
    required this.acceptedTime,
    required this.phone,
    required this.quantity,
    required this.orderID,
    required this.statusID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      tileColor: statusID == 2 ? Colors.red.withOpacity(0.4) : Colors.white,
      onTap: () {
        Get.to(() => ProductProfil(
              index: index + 1,
              acceptedTime: acceptedTime,
              comment: commit,
              location: location,
              orderID: orderID,
              phone: phone,
              quantity: quantity,
              removeButtons: false,
            ));
      },
      title: Text(location, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: size.width >= 800 ? size.width * 0.031 : size.width * 0.035, fontFamily: normsProMedium)),
      contentPadding: EdgeInsets.symmetric(vertical: size.width >= 800 ? 8 : 0),
      subtitle: Text(
        commit,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Colors.grey, fontSize: size.width >= 800 ? size.width * 0.030 : size.width * 0.032, fontFamily: normsProRegular),
      ),
      leading: size.width >= 800
          ? Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.015,
                right: size.width * 0.015,
              ),
              child: Text(
                "$index",
                style: TextStyle(color: Colors.black, fontSize: size.width >= 800 ? size.width * 0.037 : size.width * 0.04, fontFamily: normsProSemiBold),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.02,
              ),
              child: CircleAvatar(
                backgroundColor: backgroundColor,
                radius: size.width * 0.045,
                child: Text(
                  "$index",
                  style: TextStyle(color: Colors.black, fontSize: size.width * 0.04, fontFamily: normsProSemiBold),
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
