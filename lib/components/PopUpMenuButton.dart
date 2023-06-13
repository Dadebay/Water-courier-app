// ignore_for_file: file_names

import 'package:akar_suw_2/components/SetttingsButton.dart';
import 'package:akar_suw_2/controllers/SettingsController.dart';
import 'package:akar_suw_2/screens/SumOfDay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/add_page.dart';
import 'constants.dart';

class PopUpMenu extends StatelessWidget {
  PopUpMenu({Key? key}) : super(key: key);
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<String>(
          child: Icon(Icons.more_vert, size: size.width >= 800 ? size.width * 0.035 : size.width * 0.05, color: Colors.white),
          itemBuilder: (context) => <PopupMenuEntry<String>>[
                item1(size),
                item2(size),
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(const Duration(seconds: 1), () => Get.to(() => AddPage()));
                  },
                  child: Text(
                    'Gosmak'.tr,
                    style: TextStyle(
                      fontFamily: normsProSemiBold,
                      fontSize: size.width >= 800 ? size.width * 0.025 : size.width * 0.035,
                    ),
                  ),
                ),
              ]),
    );
  }

  PopupMenuItem<String> item2(Size size) {
    return PopupMenuItem(
      onTap: () {
        Future.delayed(const Duration(seconds: 0), () => Get.to(() => const SumOfDay()));
      },
      child: Text(
        'summaryOfDay'.tr,
        style: TextStyle(
          fontFamily: normsProSemiBold,
          fontSize: size.width >= 800 ? size.width * 0.025 : size.width * 0.035,
        ),
      ),
    );
  }

  PopupMenuItem<String> item1(Size size) {
    return PopupMenuItem(
      onTap: () {
        Future.delayed(
            const Duration(seconds: 0),
            () => Get.defaultDialog(
                radius: 2,
                title: "selectLanguage".tr,
                titleStyle: TextStyle(fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? size.width * 0.032 : size.width * 0.05),
                content: Column(
                  children: [
                    SettingButton(
                        name: "Rus dili",
                        onTap: () {
                          settingsController.switchLang("ru");
                          Get.back();
                        },
                        icon: Container(
                            width: size.width >= 800 ? size.width * 0.04 : size.width * 0.08,
                            height: size.width >= 800 ? size.width * 0.04 : size.width * 0.08,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                            child: ClipRRect(
                              borderRadius: borderRadius30,
                              child: Image.asset(
                                ruIcon,
                                fit: BoxFit.cover,
                              ),
                            ))),
                    SettingButton(
                        name: "Türkmen dili",
                        onTap: () {
                          settingsController.switchLang("tr");
                          Get.back();
                        },
                        icon: Container(
                            width: size.width >= 800 ? size.width * 0.04 : size.width * 0.08,
                            height: size.width >= 800 ? size.width * 0.04 : size.width * 0.08,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                            child: ClipRRect(
                              borderRadius: borderRadius30,
                              child: Image.asset(
                                tmIcon,
                                fit: BoxFit.cover,
                              ),
                            ))),
                  ],
                )));
      },
      child: Text(
        'selectLanguage'.tr,
        style: TextStyle(
          fontFamily: normsProSemiBold,
          fontSize: size.width >= 800 ? size.width * 0.025 : size.width * 0.035,
        ),
      ),
    );
  }
}
