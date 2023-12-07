import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/models/auth_user_model.dart';
import 'package:veegil/utils/api_endpoint.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  AuthUserModel? authUserModel;

  // Add this variable to store the filtered transactions
  RxList<DataUser> filteredUsers = <DataUser>[].obs;
  final Future<SharedPreferences> _currentUserNumber = SharedPreferences.getInstance();

  @override
  Future<void> onInit() async {
    super.onInit();
    final SharedPreferences prefs = await _currentUserNumber;
    final String? currentUserNumber = prefs.get('phoneNumber') as String?;
    if (currentUserNumber != null) {
      // If there is a current user number, fetch data
      fetchCurrAuthUser(currentUserNumber);
    } else {
      print('No current user number found in SharedPreferences');
    }
  }

  fetchCurrAuthUser(String targetPhoneNumber) async {
    try {
      isLoading(true);
      var header = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.authUsers);
      http.Response response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        authUserModel = AuthUserModel.fromJson(result);

        // To filter transactions for the specific phone number
        if (authUserModel?.data != null) {
          // Clear the previous filtered transactions
          filteredUsers.clear();
          // Add transactions for the specified phone number to the filtered list
          authUserModel!.data!.forEach((user) {
            if (user.phoneNumber == targetPhoneNumber) {
              filteredUsers.add(user);
            }
          });
          filteredUsers.map((t) => t.toJson());
          // Now, filteredTransactions contains only transactions related to the specified phone number
          print("Filtered Users: ${filteredUsers.map((t) => t.toJson())}");
        }
      } else {
        print('Error fetching data');
      }
    } catch (e) {
      print('Error while getting User: $e');
    }finally{
      isLoading(false);
    }
  }
}
