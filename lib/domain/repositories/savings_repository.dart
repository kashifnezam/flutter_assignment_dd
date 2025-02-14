import '../../data/models/transaction_model.dart';

abstract class SavingsRepository {
  double getCompA();
  double getCompB();
  List<String> getHistory();
  String getUserName();
  bool getIsNameSet();

  Future<void> saveCompA(double value);
  Future<void> saveCompB(double value);
  Future<void> saveHistory(List<String> history);
  Future<void> saveUserName(String name);
  Future<void> saveIsNameSet(bool value);

  Future<void> addTransaction(TransactionModel transaction);
}
