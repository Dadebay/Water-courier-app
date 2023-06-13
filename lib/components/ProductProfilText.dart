// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class TextPart extends StatelessWidget {
  final Size size;
  final IconData icon;

  final String text;
  final String text2;
  final bool variant;
  const TextPart({
    super.key,
    required this.size,
    required this.icon,
    required this.text,
    required this.text2,
    required this.variant,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(variant);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width >= 800 ? size.width * 0.02 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  icon,
                  color: kPrimaryColor,
                  size: size.width >= 800 ? size.width * 0.03 : size.width * 0.05,
                ),
              ),
              Text(
                text.tr,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: kPrimaryColor, fontSize: size.width >= 800 ? size.width * 0.04 : size.width * 0.05, fontFamily: normsProSemiBold),
              ),
              variant == true
                  ? Text(
                      "  $text2",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 12,
                      style: TextStyle(color: Colors.white, fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.045, fontFamily: normsProMedium),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          variant == true
              ? const SizedBox(
                  height: 35,
                )
              : Container(
                  width: Get.size.width,
                  padding: const EdgeInsets.only(left: 15, right: 12, top: 15, bottom: 30),
                  child: Text(
                    "  $text2",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 12,
                    style: TextStyle(color: Colors.white, fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.045, fontFamily: normsProMedium),
                  ),
                ),
        ],
      ),
    );
  }
}
