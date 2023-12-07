import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:veegil/screens/home_screen.dart';
import 'package:veegil/screens/login_screen.dart';
import 'package:veegil/screens/statistics_screen.dart';
import 'package:veegil/screens/transactions.dart';

main() async {
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}