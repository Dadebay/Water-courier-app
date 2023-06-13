// ignore_for_file: file_names

import 'package:akar_suw_2/components/constants.dart';
import 'package:akar_suw_2/components/expansionCard2.dart';
import 'package:akar_suw_2/models/UserSignInModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SumOfDay extends StatelessWidget {
  const SumOfDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
          "summaryOfDay".tr,
          style: TextStyle(fontFamily: normsProSemiBold, fontSize: size.width >= 800 ? size.width * 0.035 : size.width * 0.05, color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
          future: OrderModel().getSumOfDay(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: Lottie.asset(
                    loading2,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("noConnection1".tr, textAlign: TextAlign.center, style: TextStyle(fontSize: size.width >= 800 ? size.width * 0.025 : size.width * 0.04, fontFamily: normsProSemiBold)),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("noConnection2".tr, textAlign: TextAlign.center, style: TextStyle(fontSize: size.width >= 800 ? size.width * 0.025 : size.width * 0.04, fontFamily: normsProMedium)),
                ],
              ));
            }
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ExpansionCard2(
                  index: index,
                  order: snapshot.data![index],
                );
              },
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: backgroundColor,
                  thickness: 1,
                );
              },
            );
          }),
    );
  }
}
