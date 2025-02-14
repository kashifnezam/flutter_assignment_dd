import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/controllers/savings_controller.dart';

class HistoryScreen extends StatelessWidget {
  final SavingsController _controller = Get.find();

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Add filtering logic here
              Get.snackbar('Filter', 'Filter by date or type');
            },
          ),
        ],
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
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Savings Overview',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: BarChart(
                            BarChartData(
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value == 0 ? 'CompA' : 'CompB',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        '\$${value.toInt()}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              barGroups: [
                                BarChartGroupData(
                                  x: 0,
                                  barRods: [
                                    BarChartRodData(
                                      toY: _controller.compA.value,
                                      color: Colors.blue,
                                      width: 20,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 1,
                                  barRods: [
                                    BarChartRodData(
                                      toY: _controller.compB.value,
                                      color: Colors.green,
                                      width: 20,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Transaction History',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Obx(
                            () => ListView.builder(
                              itemCount: _controller.history.length,
                              itemBuilder: (context, index) {
                                final transaction = _controller.history[
                                    _controller.history.length - index - 1];
                                final transArray = transaction.split(":");
                                final isWithdrawal =
                                    transaction.contains('Withdrew');
                                return Card(
                                  elevation: 2,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      isWithdrawal
                                          ? Icons.arrow_circle_down
                                          : Icons.arrow_circle_up,
                                      color: isWithdrawal
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                    title: Text(
                                      transArray[2].split("\$")[0].trim(),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${transArray[0]}:${transArray[1]}",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Text(
                                      isWithdrawal
                                          ? '-\$${transaction.split('\$')[1]}'
                                          : '+\$${transaction.split('\$')[1]}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: isWithdrawal
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
