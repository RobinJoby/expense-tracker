import 'package:expense_tracker/widgets/expense_widget/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => ExpenseItem(
        data: expenses[index],
      ),
      itemCount: expenses.length,
    );
  }
}
