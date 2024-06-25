import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_widget/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreen();
  }
}

class _ExpensesScreen extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 123,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'KFC',
      amount: 212,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Football match',
      amount: 234,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Expense Tracker',
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Text(
            'ChartArea',
          ),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
            ),
          )
        ],
      ),
    );
  }
}
