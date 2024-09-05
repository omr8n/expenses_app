import 'package:expenses/data/models/espenses_model.dart';
import 'package:expenses/views/widgets/expenses_list_view_item.dart';
import 'package:flutter/material.dart';

class ExpensesListView extends StatelessWidget {
  const ExpensesListView(
      {super.key, required this.expenses, required this.removeExpense});
  final void Function(ExpensesModel expense) removeExpense;
  final List<ExpensesModel> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
            color: Theme.of(context).cardColor.withRed(9),
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) => removeExpense(expenses[index]),
          child: ExpensesListViewItem(
            expensesModel: expenses[index],
          ),
        );
      },
    );
  }
}
