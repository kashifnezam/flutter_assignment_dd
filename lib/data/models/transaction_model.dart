import '../../core/utils/date_utils.dart';

class TransactionModel {
  final String type; // 'Added' or 'Withdrew'
  final double amount;
  final DateTime dateTime;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.dateTime,
  });

  String get formattedDateTime => DateUtils.formatDateTime(dateTime);
}