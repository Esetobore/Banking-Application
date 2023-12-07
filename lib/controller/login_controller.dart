import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/screens/home_screen.dart';
import 'package:veegil/utils/api_endpoint.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Future<SharedPreferences> _currentUserNumber = SharedPreferences.getInstance();

  Future<void> loginPhone() async{
    try{
      var header  = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.login);
      Map body = {
        'phoneNumber': phoneController.text,
        'password' : passwordController.text
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: header);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (json['status'] == 'success') {
          var token = json['data']['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          final SharedPreferences currentUserNumber = await _currentUserNumber;
          await currentUserNumber.setString("phoneNumber", phoneController.text);
          phoneController.clear();
          passwordController.clear();
          Get.offAll(() => HomeScreen());
          showDialog(
              context: Get.context!,
              builder: (context) {
                return const SimpleDialog(
                  title: Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,20),
                    child: Text('Login Successful'),
                  ),
                );
              });
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
        }
        Get.to(() => const HomeScreen());
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
      }

    }catch (e){
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