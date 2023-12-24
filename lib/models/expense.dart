import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

class Expense {
  Expense({
    required this.amount,
    required this.title,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // generate unique id whenever this class initialized

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
