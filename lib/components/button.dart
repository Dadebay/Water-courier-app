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
    return Expanded(
      child: RaisedButton(
          onPressed: onTap,
          color: color,
          shape: const RoundedRectangleBorder(borderRadius: borderRadius5),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            name.tr,
            style: TextStyle(
              color: Colors.white,
              fontFamily: normsProSemiBold,
              fontSize: size.width >= 800 ? size.width * 0.03 : size.width * 0.045,
            ),
          )),
    );
  }
}
