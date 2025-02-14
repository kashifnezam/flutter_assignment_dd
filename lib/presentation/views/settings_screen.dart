import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/savings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final _controller = TextEditingController();
  final SavingsController _savingsController = Get.find();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _savingsController.setUserName(_controller.text);
                  Get.back();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
