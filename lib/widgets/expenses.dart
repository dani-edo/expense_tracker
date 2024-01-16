import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
      amount: 10,
      title: 'Watch Movie',
      date: DateTime.parse('2023-10-24'),
      category: Category.leisure,
    ),
    Expense(
      amount: 30,
      title: 'Bakso',
      date: DateTime.parse('2023-10-30'),
      category: Category.food,
    ),
    Expense(
      amount: 100,
      title: 'Tokyo January',
      date: DateTime.parse('2024-01-28'),
      category: Category.travel,
    ),
    Expense(
      amount: 8,
      title: 'Course',
      date: DateTime.parse('2024-01-28'),
      category: Category.work,
    ),
    Expense(
      amount: 8,
      title: 'Books',
      date: DateTime.parse('2024-01-28'),
      category: Category.work,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => setState(() {
          _registerExpenses.insert(expenseIndex, expense);
        }),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpenses,
        removeExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter ExpenseTracker',
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerExpenses),
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registerExpenses)),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
