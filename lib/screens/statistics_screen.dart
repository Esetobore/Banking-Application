import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veegil/controller/home_screen_controller.dart';
import 'package:veegil/controller/transactions_controller.dart';
import 'package:veegil/models/auth_user_model.dart';
import 'package:fl_chart/fl_chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final HomeController homeControllerStatisticsScreen = Get.put(HomeController());
  final TransactionHistoryController transactionHistoryController = Get.put(TransactionHistoryController());
  final Future<SharedPreferences> _currentUserNumber = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Statistics",
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Obx(() {
        if (homeControllerStatisticsScreen.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // Use filteredUsers to display user data
          List<DataUser> displayedUser =
          homeControllerStatisticsScreen.filteredUsers.isNotEmpty
              ? homeControllerStatisticsScreen.filteredUsers
              : homeControllerStatisticsScreen.authUserModel?.data ?? [];
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 100),
                    child: ElevatedButton(
                      onPressed: () async{
                        final SharedPreferences prefs = await _currentUserNumber;
                        final String? currentUserNumber = prefs.get('phoneNumber') as String?;
                        homeControllerStatisticsScreen.fetchCurrAuthUser(currentUserNumber!);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey, // Set your button color
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Balance: ${displayedUser.isNotEmpty ? displayedUser[0].balance ?? 0 : 'N/A'}",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              "Account Number: ${displayedUser.isNotEmpty ? displayedUser[0].phoneNumber : 'N/A'}",
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
                  ),
                ),
                const SizedBox(height: 30,),
                Card(
                  color: Colors.blueGrey,
                  child: SizedBox(
                    height: 450, // Set a fixed height
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false,
                          border: Border.all(
                            color: const Color(0xff000000),
                            width: 1,
                          ),
                        ),
                        minX: 0,
                        maxX: transactionHistoryController.filteredTransactions.length.toDouble() - 1,
                        minY: 10,
                        maxY: 9000000, // Adjust as per your data
                        lineBarsData: [
                          LineChartBarData(
                            spots: transactionHistoryController.filteredTransactions.asMap().entries.map((entry) {
                              return FlSpot(
                                entry.key.toDouble(),
                                entry.value.amount!.toDouble(), // Assuming amount is the Y-axis value
                              );
                            }).toList(),
                            isCurved: true,
                            colors: [Colors.red],
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: true),
                          ),
                        ],
                      ),
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
