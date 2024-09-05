import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();
final dateFormat = DateFormat.yMd();

class ExpensesModel {
  ExpensesModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v8();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return dateFormat.format(date);
  }
}

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff
};

enum Category { food, travel, leisure, work }

class EpensesBucket {
  final List<ExpensesModel> expenses;
  final Category category;

  EpensesBucket({
    required this.expenses,
    required this.category,
  });

  EpensesBucket.forCagtegory(
    List<ExpensesModel> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where(
              (element) => element.category == category,
            )
            .toList();

  double get totalEpenses {
    double sum = 0;
    for (var element in expenses) {
      sum = sum + element.amount;
    }
    return sum;
  }
}
