// ignore_for_file: file_names, always_declare_return_types, type_annotate_public_apis, avoid_dynamic_calls, unnecessary_null_comparison

import 'package:akar_suw_2/models/UserSignInModel.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class HomePageController extends GetxController {
  RxBool loginButton = false.obs;
  RxInt loading = 0.obs;
  RxInt acceptedNumber = 0.obs;
  RxInt leftNumber = 0.obs;
  final storage = GetStorage();
  RxList list = [].obs;

  void fetchRealEstates() async {
    final products = await OrderModel().getOrders();
    if (products != null) {
      loading.value = 1;
      for (final element in products) {
        list.add({
          "id": element.id,
          "location": element.location,
          "phone": element.phone,
          "quantity": element.quantity,
          "status_id": element.statusId,
          "accepted_time": element.acceptedTime,
          "comment": element.commit,
        });
      }
    } else if (products == null) {
      loading.value = 2;
    } else {
      loading.value = 3;
    }
  }

  writeFirebaseToken({required String token}) {
    storage.write("firebase", token);
    return storage.read("firebase") == null ? true : false;
  }
}
