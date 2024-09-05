import 'package:expenses/data/models/espenses_model.dart';
import 'package:flutter/material.dart';

class ExpensesListViewItem extends StatelessWidget {
  const ExpensesListViewItem({super.key, required this.expensesModel});
  final ExpensesModel expensesModel;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expensesModel.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              children: [
                Text(
                  '\$ ${expensesModel.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expensesModel.category],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      expensesModel.formatedDate,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
