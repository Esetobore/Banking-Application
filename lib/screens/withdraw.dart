import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/controller/home_screen_controller.dart';
import 'package:veegil/controller/withdraw_controller.dart';
import 'package:veegil/models/auth_user_model.dart';
import '../widget/input_field.dart';
import '../widget/submit_button.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  WithdrawController withdrawController = Get.put(WithdrawController());
  HomeController withdrawHomeController = Get.put(HomeController());
  final Future<SharedPreferences> _currentUserNumber = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account Withdraw'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Obx((){
      if (withdrawController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        // Use filteredUsers to display user data
        List<DataUser> displayedUser =
        withdrawHomeController.filteredUsers.isNotEmpty
            ? withdrawHomeController.filteredUsers
            : withdrawHomeController.authUserModel?.data ?? [];
        return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 100, 35, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Account Number: ${displayedUser.isNotEmpty
                      ? displayedUser[0].phoneNumber
                      : 'N/A'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                  const SizedBox(
                    height: 20,
                  ),
                  InputTextFieldWidget(
                    withdrawController.amountController, TextInputType.number,false,
                    'Amount',),
                  const SizedBox(
                    height: 20,
                  ),
                  SubmitButton(
                    onPressed: () => withdrawController.removeFunds(),
                    title: 'Withdraw',
                  )
                ],
              ),
            )
        );
      }
        },
        )
    );
  }
  }
