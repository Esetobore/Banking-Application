import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/screens/home_screen.dart';
import 'package:veegil/screens/login_screen.dart';
import 'package:veegil/utils/api_endpoint.dart';

class SignUpController extends GetxController {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<void> signUpPhone() async{
      try{
        var header  = {'Content-Type': 'application/json'};
        var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.signup);
        Map body = {
          'phoneNumber': phoneController.text,
          'password' : passwordController.text
        };

        http.Response response = await http.post(url, body: jsonEncode(body), headers: header);
        if (response.statusCode == 201) {
          final json = jsonDecode(response.body);
          if (json['status'] == 'success') {
            phoneController.clear();
            passwordController.clear();
            Get.off(() => const LoginScreen());
          } else {
            throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
          }
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
        }

      }catch (e){
        Get.back();
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text('Alert'),
                contentPadding: const EdgeInsets.all(20),
                children: [Text(e.toString())],
              );
            });
      }
}
}