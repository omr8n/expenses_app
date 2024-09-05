// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:expenses/views/chart/chart.dart';
import 'package:flutter/material.dart';

import 'package:expenses/views/widgets/expenses_list_view.dart';

import '../../data/models/espenses_model.dart';

class ExpensesViewBody extends StatelessWidget {
  const ExpensesViewBody({
    super.key,
    required this.removeExpense,
    required this.expenses,
  });

  final void Function(ExpensesModel expense) removeExpense;
  final List<ExpensesModel> expenses;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width < 600
        ? Column(
            children: [
              Expanded(
                child: Chart(
                  expenes: expenses,
                ),
              ),
              Expanded(
                  child: ExpensesListView(
                      expenses: expenses, removeExpense: removeExpense))
            ],
          )
        : Row(
            children: [
              Expanded(
                child: Chart(
                  expenes: expenses,
                ),
              ),
              Expanded(
                  child: ExpensesListView(
                      expenses: expenses, removeExpense: removeExpense))
            ],
          );
  }
}
