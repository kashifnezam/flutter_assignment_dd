import 'package:get/get.dart';
import '../../data/repositories/savings_repository.dart';
import '../../domain/repositories/savings_repository.dart';
import '../../domain/use_cases/add_savings_use_case.dart';
import '../../data/models/transaction_model.dart';

class SavingsController extends GetxController {
  final SavingsRepositorys repository;
  final AddSavingsUseCase addSavingsUseCase;

  SavingsController(this.repository, this.addSavingsUseCase);

  var compA = 0.0.obs;
  var compB = 0.0.obs;
  var history = <String>[].obs;
  var userName = ''.obs;
  var isNameSet = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    compA.value = repository.getCompA();
    compB.value = repository.getCompB();
    history.value = repository.getHistory();
    userName.value = repository.getUserName();
    isNameSet.value = repository.getIsNameSet();
  }

  void setUserName(String name) {
    userName.value = name;
    isNameSet.value = true;
    repository.saveUserName(name);
    repository.saveIsNameSet(true);
  }

  Future<void> addSavings(double amount) async {
    await addSavingsUseCase.execute(amount);
    loadData();
  }

  Future<void> withdraw(String component, double amount) async {
    if (amount <= 0) throw Exception('Invalid amount');
    if (component == 'CompA' && compA.value >= amount) {
      compA.value -= amount;
    } else if (component == 'CompB' && compB.value >= amount) {
      compB.value -= amount;
    } else {
      throw Exception('Insufficient balance');
    }
    await repository.saveCompA(compA.value);
    await repository.saveCompB(compB.value);
    await repository.addTransaction(TransactionModel(
      type: 'Withdrew from $component',
      amount: amount,
      dateTime: DateTime.now(),
    ));
    loadData();
  }
}
