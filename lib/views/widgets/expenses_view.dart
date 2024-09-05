import 'package:expenses/data/models/espenses_model.dart';

import 'package:expenses/views/widgets/expenses_view_body.dart';
import 'package:flutter/material.dart';

import 'add_expenses_bottom_sheet.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({
    super.key,
  });

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  final List<ExpensesModel> expneses = [
    ExpensesModel(
        title: "orman",
        amount: 10,
        date: DateTime.now(),
        category: Category.food),
    ExpensesModel(
        title: "qamar",
        amount: 43,
        date: DateTime.now(),
        category: Category.work),
    ExpensesModel(
        title: "ali",
        amount: 20,
        date: DateTime.now(),
        category: Category.leisure),
    ExpensesModel(
        title: "fatema",
        amount: 30,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void _addExpense(ExpensesModel expense) {
    setState(() {
      expneses.add(expense);
    });
  }

  void _removeExpense(ExpensesModel expense) {
    setState(() {
      expneses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    context: context,
                    builder: (context) {
                      return AddExpensesBottomSheet(
                        addExpense: _addExpense,
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: ExpensesViewBody(
            removeExpense: _removeExpense, expenses: expneses));
  }
}


// ListView(
//           children: [
//             Column(
//               children: [
//                 ...expnese.map(
//                   (e) => Text(e.id),
//                 )
//               ],
//             ),
//           ],
//         ),