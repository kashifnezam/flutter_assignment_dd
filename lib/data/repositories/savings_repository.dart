import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class SavingsRepositorys {
  final SharedPreferences _prefs;

  SavingsRepositorys(this._prefs);

  double getCompA() => _prefs.getDouble('compA') ?? 0.0;
  double getCompB() => _prefs.getDouble('compB') ?? 0.0;
  List<String> getHistory() => _prefs.getStringList('history') ?? [];
  String getUserName() => _prefs.getString('userName') ?? '';
  bool getIsNameSet() => _prefs.getBool('isNameSet') ?? false;

  Future<void> saveCompA(double value) async => await _prefs.setDouble('compA', value);
  Future<void> saveCompB(double value) async => await _prefs.setDouble('compB', value);
  Future<void> saveHistory(List<String> history) async => await _prefs.setStringList('history', history);
  Future<void> saveUserName(String name) async => await _prefs.setString('userName', name);
  Future<void> saveIsNameSet(bool value) async => await _prefs.setBool('isNameSet', value);

  Future<void> addTransaction(TransactionModel transaction) async {
    final history = getHistory();
    history.add('${transaction.formattedDateTime}: ${transaction.type} \$${transaction.amount.toStringAsFixed(2)}');
    await saveHistory(history);
  }
}