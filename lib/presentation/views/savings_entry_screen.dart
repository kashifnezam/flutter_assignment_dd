import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/savings_controller.dart';

class SavingsEntryScreen extends StatelessWidget {
  final _controller = TextEditingController();
  final SavingsController _savingsController = Get.find();

  SavingsEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Savings',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Get.theme.colorScheme.primary.withOpacity(0.1),
              Get.theme.colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Enter the amount you want to add to your savings.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _controller.clear(),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(_controller.text) ?? 0.0;
                  if (amount <= 0) {
                    Get.snackbar('Error', 'Please enter a valid amount');
                    return;
                  }
                  Get.defaultDialog(
                    title: 'Confirm',
                    middleText:
                        'Are you sure you want to add \$${amount.toStringAsFixed(2)} to your savings?',
                    textConfirm: 'Yes',
                    textCancel: 'No',
                    onConfirm: () {
                      _savingsController.addSavings(amount);
                      Get.back();
                      Get.back();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Get.theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Add Savings',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
