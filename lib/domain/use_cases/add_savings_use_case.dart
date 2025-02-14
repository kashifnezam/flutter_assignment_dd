import 'package:flutter_assignment_dd/data/repositories/savings_repository.dart';

import '../repositories/savings_repository.dart';
import '../../data/models/transaction_model.dart';

class AddSavingsUseCase {
  final SavingsRepositorys repository;

  AddSavingsUseCase(this.repository);

  Future<void> execute(double amount) async {
    if (amount <= 0) throw Exception('Invalid amount');
    final compA = repository.getCompA() + amount / 2;
    final compB = repository.getCompB() + amount / 2;
    await repository.saveCompA(compA);
    await repository.saveCompB(compB);
    await repository.addTransaction(TransactionModel(
      type: 'Added',
      amount: amount,
      dateTime: DateTime.now(),
    ));
  }
}