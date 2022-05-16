// ignore_for_file: file_names, always_use_package_imports, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:akar_suw_2/components/constants.dart';
import 'package:akar_suw_2/controllers/HomePageController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'AuthModel.dart';

class UserSignInModel {
  Future login({required String phone, required String password, required String fireBaseCode}) async {
    final response = await http.post(Uri.parse("$authServerUrl/api/delivery/login"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "phone": phone,
          "password": password,
          "firebase_code": fireBaseCode,
        }));

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      Auth().setToken(responseJson["access_token"]);
      Auth().setRefreshToken(responseJson["refresh_token"]);
      return true;
    } else {
      return response.statusCode;
    }
  }
}

class OrderModel {
  OrderModel({this.id, this.acceptedTime, this.commit, this.location, this.phone, this.quantity, this.statusId});

  factory OrderModel.fromJson(Map<dynamic, dynamic> json) {
    return OrderModel(
      id: json["id"] as int,
      quantity: json["quantity"] as int,
      statusId: json["status_id"] as int,
      location: json["location"] as String,
      phone: json["phone"] as String,
      acceptedTime: json["accepted_time"] as String,
      commit: json["comment"] as String,
    );
  }

  final String? acceptedTime;
  final String? commit;
  final int? id;
  final String? location;
  final String? phone;
  final int? quantity;
  final int? statusId;

  Future<List<OrderModel>> getOrders() async {
    final List<OrderModel> order = [];
    final token = await Auth().getToken();
    final response = await http.get(
      Uri.parse(
        "$serverURL/api/delivery/get-orders",
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["rows"];
      for (final Map product in responseJson) {
        order.add(OrderModel.fromJson(product));
      }
      return order;
    } else {
      return [];
    }
  }

  Future<List<OrderModel>> getSumOfDay() async {
    final List<OrderModel> order = [];
    final token = await Auth().getToken();
    final response = await http.get(
      Uri.parse(
        "$serverURL/api/delivery/get-all-orders-for-day",
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["rows"];
      for (final Map product in responseJson) {
        order.add(OrderModel.fromJson(product));
      }
      return order;
    } else {
      return [];
    }
  }

  Future accepted({Map<String, dynamic>? body, int? id}) async {
    final token = await Auth().getToken();
    final response = await http.post(
        Uri.parse(
          "$serverURL/api/delivery/update-order/$id",
        ),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(body));
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future get() async {
    final token = await Auth().getToken();
    final response = await http.get(
      Uri.parse(
        "$serverURL/api/delivery/get-orders-for-day",
      ),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["rows"];
      int a = int.parse(responseJson["delivered"]);
      int b = int.parse(responseJson["others"]);
      Get.find<HomePageController>().acceptedNumber.value = a;
      Get.find<HomePageController>().leftNumber.value = b;

      return true;
    } else {
      return false;
    }
  }
}
