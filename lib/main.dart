import 'package:flutter/material.dart';
import 'package:flutter_assignment_dd/presentation/views/splash_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_colors.dart';
import 'data/repositories/savings_repository.dart';
import 'domain/controllers/savings_controller.dart';
import 'domain/use_cases/add_savings_use_case.dart';
import 'presentation/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final repository = SavingsRepositorys(prefs);
  final addSavingsUseCase = AddSavingsUseCase(repository);
  final savingsController = SavingsController(repository, addSavingsUseCase);
  Get.put(savingsController);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const SplashScreen(),
    );
  }
}
