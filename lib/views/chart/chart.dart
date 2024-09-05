import 'dart:developer';

import 'package:expenses/data/models/espenses_model.dart';
import 'package:expenses/views/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenes});
  final List<ExpensesModel> expenes;
  List<EpensesBucket> get bucket {
    return [
      EpensesBucket.forCagtegory(expenes, Category.food),
      EpensesBucket.forCagtegory(expenes, Category.work),
      EpensesBucket.forCagtegory(expenes, Category.leisure),
      EpensesBucket.forCagtegory(expenes, Category.leisure),
    ];
  }

  double get maxTotalExpenses {
    double maxTotalExpenses = 0;

    for (var element in bucket) {
      if (element.totalEpenses > maxTotalExpenses) {
        maxTotalExpenses = element.totalEpenses;
      }
    }
    return maxTotalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(builder: (context, constraints) {
      log(constraints.minHeight.toString());
      log(constraints.maxHeight.toString());
      log(constraints.minWidth.toString());
      log(constraints.maxWidth.toString());
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        height: constraints.minHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(.1),
                  Theme.of(context).colorScheme.primary.withOpacity(.2),
                  Theme.of(context).colorScheme.primary.withOpacity(.3),
                ])),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final element in bucket)
                    ChartBar(
                      fill: element.totalEpenses == 0
                          ? 0
                          : element.totalEpenses / maxTotalExpenses,
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: bucket
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          categoryIcons[e.category],
                          color: isDarkMode
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
