// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class SettingButton extends StatelessWidget {
  final String name;
  final Function() onTap;
  final Widget icon;
  const SettingButton({Key? key, required this.name, required this.onTap, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListTile(
      onTap: onTap,
      tileColor: Colors.white,
      minVerticalPadding: 23,
      title: Text(
        name.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Colors.black, fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? size.width * 0.03 : size.width * 0.045),
      ),
      trailing: icon,
    );
  }
}
