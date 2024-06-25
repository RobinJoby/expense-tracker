import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.data});

  final Expense data;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Column(
          children: [
            Text(data.title),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  '\$${data.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[data.category],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      data.formattedDate.toString(),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
