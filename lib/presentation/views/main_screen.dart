import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/controllers/savings_controller.dart';
import 'savings_entry_screen.dart';
import 'withdrawal_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';
import '../../core/constants/app_colors.dart';

class MainScreen extends StatelessWidget {
  final SavingsController _controller = Get.find();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!_controller.isNameSet.value) {
      Future.delayed(Duration.zero, () {
        Get.to(() => SettingsScreen());
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Savings Manager',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.to(() => SettingsScreen()),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Obx(() => Text(
                    'Welcome, ${_controller.userName.value}!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(height: 32),
              _buildTotalSavingsCard(),
              const SizedBox(height: 32),
              Row(
                children: [
                  Obx(
                    () {
                      return Expanded(
                        child: _buildBalanceCard(
                            'CompA',
                            _controller.compA.value,
                            [Colors.blue, Colors.lightBlue],
                            Icons.account_balance),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  Obx(
                    () {
                      return Expanded(
                        child: _buildBalanceCard(
                            'CompB',
                            _controller.compB.value,
                            [Colors.green, Colors.lightGreen],
                            Icons.account_balance_wallet),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildPieChart(),
              const SizedBox(height: 32),
              _buildQuickActions(),
              const SizedBox(height: 32),
              _buildRecentTransactions(),
              const SizedBox(height: 16),
              _buildCompleteHistoryButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalSavingsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Total Savings',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(
                    '\$${(_controller.compA.value + _controller.compB.value).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: (_controller.compA.value + _controller.compB.value) /
                    100000, // Example goal: $100,000
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Goal: \$100,000',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(
      String title, double amount, List<Color> colors, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return Obx(
      () {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 300,
            child: Column(
              children: [
                const Text(
                  'Savings Distribution',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: _controller.compA.value,
                          color: Colors.blue,
                          title: 'CompA',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: _controller.compB.value,
                          color: Colors.green,
                          title: 'CompB',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      centerSpaceRadius: 60,
                      sectionsSpace: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegend(Colors.blue, 'CompA'),
                    const SizedBox(width: 16),
                    _buildLegend(Colors.green, 'CompB'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            'Add Savings',
            Icons.add,
            () => Get.to(() => SavingsEntryScreen()),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            'Withdraw',
            Icons.remove,
            () => Get.to(() => WithdrawalScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => ListView.builder(
                  reverse: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _controller.history.length > 3
                      ? 3
                      : _controller.history.length,
                  itemBuilder: (context, index) {
                    final transaction = _controller
                        .history[_controller.history.length - index - 1];
                    final transArray = transaction.split(":");
                    final isWithdrawal = transaction.contains('Withdrew');
                    return ListTile(
                      leading: Icon(
                        isWithdrawal
                            ? Icons.arrow_circle_down
                            : Icons.arrow_circle_up,
                        color:
                            isWithdrawal ? AppColors.error : AppColors.success,
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
                              ? AppColors.error
                              : AppColors.success,
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCompleteHistoryButton() {
    return ElevatedButton(
      onPressed: () => Get.to(() => HistoryScreen()),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'View Complete History',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
