// ignore_for_file: file_names, unrelated_type_equality_checks

import 'package:akar_suw_2/components/PopUpMenuButton.dart';
import 'package:akar_suw_2/components/bottomSheet.dart';
import 'package:akar_suw_2/components/constants.dart';
import 'package:akar_suw_2/components/expansionCard.dart';
import 'package:akar_suw_2/controllers/HomePageController.dart';
import 'package:akar_suw_2/models/UserSignInModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Get.find<HomePageController>().fetchRealEstates();
    OrderModel().get();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refreshPhotos() async {
    Get.find<HomePageController>().loading.value = 0;
    Get.find<HomePageController>().list.clear();

    await Future.delayed(const Duration(seconds: 1));

    Get.find<HomePageController>().fetchRealEstates();
  }

  final HomePageController homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        bottomSheet: BottomSheetMine(),
        appBar: appBarr(size),
        body: RefreshIndicator(
          onRefresh: _refreshPhotos,
          key: _refreshIndicatorKey,
          child: Obx(() {
            if (homePageController.loading.value == 2 || homePageController.loading.value == 0) {
              return loader();
            } else if (homePageController.loading.value == 3) {
              return noconnection(size);
            }

            return homePageController.list.toString() == "[]"
                ? noOrder(size)
                : ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return ExpansionCard(
                        index: homePageController.list[index]["id"],
                        location: homePageController.list[index]["location"],
                        commit: homePageController.list[index]["comment"],
                        acceptedTime: homePageController.list[index]["accepted_time"],
                        quantity: "${homePageController.list[index]["quantity"]}",
                        orderID: homePageController.list[index]["id"],
                        statusID: homePageController.list[index]["status_id"],
                        phone: homePageController.list[index]["phone"],
                      );
                    },
                    itemCount: homePageController.list.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: backgroundColor,
                        thickness: 1,
                      );
                    },
                  );
          }),
        ));
  }

  AppBar appBarr(Size size) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Text(
        "Akar Suw",
        style: TextStyle(
          color: Colors.white,
          fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.05,
          fontFamily: normsProBold,
        ),
      ),
      centerTitle: true,
      actions: [
        PopUpMenu(),
      ],
    );
  }

  Center noconnection(Size size) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("noConnection1".tr, textAlign: TextAlign.center, style: TextStyle(fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.05, fontFamily: normsProSemiBold)),
        const SizedBox(
          height: 15,
        ),
        Text("noConnection2".tr, textAlign: TextAlign.center, style: TextStyle(fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.05, fontFamily: normsProMedium)),
      ],
    ));
  }

  Center loader() {
    return Center(
      child: SizedBox(
        width: 140,
        height: 140,
        child: Lottie.asset(
          loading2,
        ),
      ),
    );
  }

  Center noOrder(Size size) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/lottie/emptyProducts.png",
            color: Colors.grey,
            width: size.width >= 800 ? size.width * 0.4 : size.width * 0.5,
            height: size.width >= 800 ? size.width * 0.4 : size.width * 0.5,
          ),
          Text(
            "NoOrder".tr,
            style: TextStyle(color: Colors.white, fontSize: size.width >= 800 ? size.width * 0.04 : size.width * 0.05, fontFamily: normsProMedium),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _refreshPhotos();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: borderRadius5,
                ),
              ),
              child: Text(
                "try".tr,
                style: const TextStyle(color: Colors.white, fontFamily: normsProBold, fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }
}
