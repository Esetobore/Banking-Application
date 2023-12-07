import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/models/trasactions_history_models.dart';
import 'package:veegil/screens/home_screen.dart';
import 'package:veegil/utils/api_endpoint.dart';

class TransactionHistoryController extends GetxController {
  var isLoading = false.obs;
  TransactionsModel? transactionsModel;
  final Future<SharedPreferences> _currentUserNumber = SharedPreferences.getInstance();

  // Add this variable to store the filtered transactions
  RxList<Data> filteredTransactions = <Data>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final SharedPreferences prefs = await _currentUserNumber;
    final String? currentUserNumber = prefs.get('phoneNumber') as String?;
    if (currentUserNumber != null) {
      // If there is a current user number, fetch data
      fetchData(currentUserNumber);
    } else {
      print('No current user number found in SharedPreferences');
    }
  }

  fetchData(String targetPhoneNumber) async {
    try {
      isLoading(true);
      var header = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.transactions_history);
      http.Response response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        transactionsModel = TransactionsModel.fromJson(result);

        // Assuming you want to filter transactions for this specific phone number
        if (transactionsModel?.data != null) {
          // Clear the previous filtered transactions
          filteredTransactions.clear();
          // Add transactions for the specified phone number to the filtered list
          transactionsModel!.data!.forEach((transaction) {
            if (transaction.phoneNumber == targetPhoneNumber) {
              filteredTransactions.add(transaction);
            }
          });
          if (filteredTransactions.isEmpty) {
            print('No transactions found for the specified phone number');
            Get.offAll(() => const HomeScreen());
            showDialog(
                context: Get.context!,
                builder: (context) {
                  return const SimpleDialog(
                    title: Text('Alert'),
                    contentPadding: EdgeInsets.all(20),
                    children: [Text('No Transactions have been made')],
                  );
                });
            // Handle the case where there are no transactions
            // You might want to display a message or update the UI accordingly
          } else {
            filteredTransactions.map((t) => t.toJson());
            // Now, filteredTransactions contains only transactions related
        }
      } else {
        print('Error fetching data');
      }
    }
  }catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
