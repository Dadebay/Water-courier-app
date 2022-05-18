import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class button extends StatelessWidget {
  final Function() onTap;
  final String name;
  final Color color;
  final Size size;

  const button({super.key, required this.onTap, required this.name, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      child: RaisedButton(
          onPressed: onTap,
          color: color,
          shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
          padding: EdgeInsets.symmetric(vertical: size.width >= 800 ? 15 : 8),
          child: Text(
            name.tr,
            style: TextStyle(
              color: Colors.white,
              fontFamily: normsProSemiBold,
              fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.045,
            ),
          )),
    );
  }
}
