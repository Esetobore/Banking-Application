import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/utils/api_endpoint.dart';

class WithdrawController extends GetxController{
      var isLoading = false.obs;
      TextEditingController amountController = TextEditingController();
      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final Future<SharedPreferences> _currentUserNumber = SharedPreferences.getInstance();

      //var balance = json;

      Future<void>removeFunds() async {
        final SharedPreferences prefs = await _prefs;
        final String token = prefs.getString('token')?? 'defaultToken';
        try {
          isLoading(true);
          var header = {
            'Content-Type': 'application/json',
          'Authorization': token};
          var url = Uri.parse(
              ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.withDraw);
          final SharedPreferences prefs = await _currentUserNumber;
          final String? currentUserNumber = prefs.get('phoneNumber') as String?;
          Map body = {
            'phoneNumber': currentUserNumber,
            'amount': amountController.text
          };

          http.Response response = await http.post(url, body: jsonEncode(body), headers: header);
          if (response.statusCode == 200) {
            final Map<String, dynamic> json = jsonDecode(response.body);
            //var balance = json['data']['balance'];
            if (json['status'] == 'success') {
                // Sufficient balance, proceed with the withdrawal
                amountController.clear();
                showDialog(
                  context: Get.context!,
                  builder: (context) {
                    return const SimpleDialog(
                      title:  Text('Withdraw Successful'),
                      contentPadding:  EdgeInsets.all(20),
                      //children: [Text(balance.toString())],
                    );
                  },
                );
            } else {
              throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
            }
          } else {
            throw jsonDecode(response.body)["message"] ?? "Unknown Error Occurred";
          }
        }catch(e){
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: const Text('Alert'),
                  contentPadding: const EdgeInsets.all(20),
                  children: [Text(e.toString(), style: const TextStyle(
                    fontSize: 25,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold
                  ),),
                  //Text(balance.decoder.toString())
                    ],
                );
              });
        }finally{
          isLoading(false);
        }

      }
}