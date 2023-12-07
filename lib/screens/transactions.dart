
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:veegil/controller/transactions_controller.dart';
import 'package:veegil/models/trasactions_history_models.dart';

class Transactions extends StatelessWidget {
   Transactions({super.key});

  final TransactionHistoryController transactionHistoryController = Get.put(TransactionHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Obx(() {
        if (transactionHistoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // Use filteredTransactions to display data
          List<Data> displayedTransactions =
          transactionHistoryController.filteredTransactions.isNotEmpty
              ? transactionHistoryController.filteredTransactions
              : transactionHistoryController.transactionsModel?.data ?? [];
          return ListView.builder(
            itemCount: displayedTransactions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 5,
                  color: Colors.blueGrey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayedTransactions[index].type ?? 'no type',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ('Amount: ${displayedTransactions[index].amount ?? 0}').toString(),
                          style: const TextStyle(fontSize: 16)
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          displayedTransactions[index].created ?? 'no data',
                          style: const TextStyle(fontSize: 16)
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
