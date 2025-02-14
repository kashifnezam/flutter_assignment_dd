import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/savings_controller.dart';

// ignore: must_be_immutable
class WithdrawalScreen extends StatelessWidget {
  final _controller = TextEditingController();
  final SavingsController _savingsController = Get.find();
  final RxString _selectedComponent = 'CompA'.obs;

  WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Withdraw',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  'Select the component and enter the amount you want to withdraw.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                DropdownButtonFormField<String>(
                  value: _selectedComponent.value, // Use the reactive value
                  items: ['CompA', 'CompB'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _selectedComponent.value = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Component',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.account_balance),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  return Text(
                    'Current Balance: \$${_selectedComponent.value == 'CompA' ? _savingsController.compA.value.toStringAsFixed(2) : _savingsController.compB.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                const SizedBox(height: 16),
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
                          'Are you sure you want to withdraw \$${amount.toStringAsFixed(2)} from $_selectedComponent?',
                      textConfirm: 'Yes',
                      textCancel: 'No',
                      onConfirm: () {
                        _savingsController.withdraw(
                            _selectedComponent.value, amount);
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
                      Icon(Icons.remove, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Withdraw',
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
      ),
    );
  }
}
