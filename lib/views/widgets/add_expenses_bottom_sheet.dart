// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../data/models/espenses_model.dart';
import 'add_expenses_form.dart';

class AddExpensesBottomSheet extends StatelessWidget {
  const AddExpensesBottomSheet({
    super.key,
    required this.addExpense,
  });
  final void Function(ExpensesModel expense) addExpense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: AddExpensesForm(
        addExpense: addExpense,
      ),
    );
  }
}
