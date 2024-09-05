// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses/views/widgets/custom_button.dart';

import '../../data/models/espenses_model.dart';
import 'custom_text_field.dart';

class AddExpensesForm extends StatefulWidget {
  const AddExpensesForm({
    super.key,
    required this.addExpense,
  });
  final void Function(ExpensesModel expense) addExpense;

  @override
  State<AddExpensesForm> createState() => _AddExpensesFormState();
}

class _AddExpensesFormState extends State<AddExpensesForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  //String? title, subTitle;
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();
  DateTime? selectedDate;
  final formatter = DateFormat.yMd();

  Category? selctedCategory = Category.food;
  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            CustomTextField(
              maxLength: 50,
              controller: title,
              onSaved: (value) {
                ///    title = value;
              },
              hint: 'title',
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    prefix: const Text("\$"),
                    keyboardType: TextInputType.number,
                    controller: amount,
                    onSaved: (value) {
                      // subTitle = value;
                    },
                    hint: 'amount',
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedDate == null
                          ? "No selected Date"
                          : formatter.format(selectedDate!)),
                      IconButton(
                          onPressed: () async {
                            DateTime now = DateTime.now();
                            final firstDate =
                                DateTime(now.year - 1, now.month, now.day);
                            // final lastDate = DateTime(now.year - 1);
                            final DateTime? pickedDate = await showDatePicker(
                              initialDate: now,
                              context: context,
                              firstDate: firstDate,
                              lastDate: now,
                            );
                            setState(() {
                              selectedDate = pickedDate;
                            });
                            // .then(
                            //   (value) => log(value.toString()
                            //   ),
                            // );
                          },
                          icon: const Icon(Icons.calendar_month_outlined))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                DropdownButton(
                  value: selctedCategory,
                  items: Category.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name.toUpperCase(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newCat) {
                    if (newCat == null) {
                      return;
                    }
                    setState(() {
                      selctedCategory = newCat;
                    });
                  },
                ),
                CustomButton(
                  title: "Save ",
                  onPressed: () {
                    final enteredAmount = double.tryParse(amount.text);
                    final amountIsInvalid =
                        enteredAmount == null || enteredAmount <= 0;
                    //    final snackBar = SnackBar(content: Text("Error"));
                    if (title.text.trim().isEmpty ||
                        amountIsInvalid ||
                        selectedDate == null) {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     actions: [],
                      //   ),
                      // );
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Dialog Title',
                        desc: 'Dialog description here.............',
                        btnCancelOnPress: () {
                          Navigator.pop(context);
                        },
                        btnOkOnPress: () {},
                      ).show();
                    } else {
                      widget.addExpense(
                        ExpensesModel(
                            title: title.text,
                            amount: enteredAmount,
                            date: selectedDate!,
                            category: selctedCategory!),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
                CustomButton(
                  title: "Cancel",
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
