import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veegil/controller/home_screen_controller.dart';
import 'package:veegil/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/models/auth_user_model.dart';
import 'package:veegil/screens/login_screen.dart';
import 'package:veegil/screens/statistics_screen.dart';
import 'package:veegil/screens/transactions.dart';
import 'package:veegil/screens/transfer.dart';
import 'package:veegil/screens/withdraw.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Future<SharedPreferences> _currentUserNumber = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // Use filteredUsers to display user data
          List<DataUser> displayedUser =
          homeController.filteredUsers.isNotEmpty
              ? homeController.filteredUsers
              : homeController.authUserModel?.data ?? [];
          return SafeArea(
            child: Column(
              children: [
                 Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Welcome! \nDev User', style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(
                        width: 180,
                      ),
                      IconButton(
                        onPressed: () async {
                          final SharedPreferences prefs = await _prefs;
                          prefs.clear();
                          final SharedPreferences currUser = await _currentUserNumber;
                          currUser.clear();
                          Get.offAll(() => const LoginScreen());
                        },
                        icon: const Icon(Icons.logout, color: Colors.black,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 45,),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Card(
                    color: Colors.blueGrey,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: [
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Get.to(() => const TransferScreen());;
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(90, 70),
                                  backgroundColor: Colors.grey,
                                  // Set your preferred button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the border radius as needed
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.swap_horiz, size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8),
                                    Text('Transfer', style: TextStyle(
                                      fontSize: 13, color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () async {
                                  Get.to(() => const WithdrawScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(90, 70),
                                  backgroundColor: Colors.grey,
                                  // Set your preferred button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the border radius as needed
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.keyboard_double_arrow_down,
                                      size: 25, color: Colors.white,
                                    ),
                                    SizedBox(height: 8),
                                    Text('Withdraw', style: TextStyle(
                                      fontSize: 13, color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () async {
                                  Get.to(() => const Statistics());
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(90, 70),
                                  backgroundColor: Colors.grey,
                                  // Set your preferred button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the border radius as needed
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.bar_chart, size: 24,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8),
                                    Text('Statistics', style: TextStyle(
                                      fontSize: 13, color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Get.offAll(null);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(90, 70),
                                  backgroundColor: Colors.grey,
                                  // Set your preferred button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the border radius as needed
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.account_balance_wallet, size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8),
                                    Text('    Bills\nPayment', style: TextStyle(
                                      fontSize: 13, color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () async {
                                  final SharedPreferences prefs = await _prefs;
                                  print(prefs.get('token'));
                                  final SharedPreferences CurrUser = await _currentUserNumber;
                                  print(CurrUser.get('phoneNumber'));
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(90, 70),
                                  backgroundColor: Colors.grey,
                                  // Set your preferred button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the border radius as needed
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sports_soccer, size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8),
                                    Text('Sports', style: TextStyle(
                                      fontSize: 13, color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () async {
                                  Get.to(() => Transactions());
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(90, 70),
                                  backgroundColor: Colors.grey,
                                  // Set your preferred button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the border radius as needed
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.history, size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8),
                                    Text('History', style: TextStyle(
                                      fontSize: 13, color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Card(
                  color: Colors.blueGrey,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Balance: ${displayedUser.isNotEmpty
                              ? displayedUser[0].balance ?? 0
                              : 'N/A'}",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          "Account Number: ${displayedUser.isNotEmpty
                              ? displayedUser[0].phoneNumber
                              : 'N/A'}",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        }),
    );
  }
}