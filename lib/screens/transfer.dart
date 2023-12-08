import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veegil/controller/trasnfer_controller.dart';
import 'package:veegil/widget/input_field.dart';
import 'package:veegil/widget/submit_button.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TransferController transferController = Get.put(TransferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Transfer'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35,100,35,0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                InputTextFieldWidget(
                    transferController.TphoneNumberController,TextInputType.phone,false, 'PhoneNumber'),
                const SizedBox(
                  height: 20,
                ),
                InputTextFieldWidget(
                transferController.amountController,TextInputType.number,false, 'Amount',),
                const SizedBox(
                  height: 20,
                ),
                SubmitButton(
                  onPressed: () => transferController.transferFunds(),
                  title: 'Transfer',
                )
              ],
            ),
          )
      ),
    );
  }
}
