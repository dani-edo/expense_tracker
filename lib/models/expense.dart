import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Expense {
  Expense({
    required this.amount,
    required this.title,
    required this.date,
  }) : id = uuid.v4(); // generate unique id whenever this class initialized

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}
