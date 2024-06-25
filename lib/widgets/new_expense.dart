import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleInput(String title) {
  //   _enteredTitle = title;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      currentDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final finalAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = finalAmount == null || finalAmount <= 0;
    if (_titleController.text.isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category is selected.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
              ),
            ),
          ],
        ),
      );
      return;
    }
  }

  @override
  void dispose() {
    _titleController
        .dispose(); //important step to remove the controller from memory when the state is removed
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              maxLength: 50,
              // onChanged: _saveTitleInput,
              controller: _titleController,
              // keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 50,
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      prefix: Text('\$ '),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map(
                    (category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name,
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text(
                    "Save Expense",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
