import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
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
      title: 'Football match',
      amount: 234,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense data) {
    setState(() {
      _registeredExpenses.add(data);
    });
  }

  void _removeExpense(Expense data) {
    final dataIndex = _registeredExpenses.indexOf(data);
    setState(() {
      _registeredExpenses.remove(data);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //to clear if snackbars are already present
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted '),
        duration: const Duration(
          seconds: 3,
        ),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(dataIndex, data);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget activeScreen =
        const Center(child: Text('No expenses found. Start adding some!'));
    if (_registeredExpenses.isNotEmpty) {
      activeScreen = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
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
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: activeScreen,
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: activeScreen,
                )
              ],
            ),
    );
  }
}
