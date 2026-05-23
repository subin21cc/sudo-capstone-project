import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/design_system/molecules/chart_card.dart';
import 'package:oncare/design_system/molecules/metric_card.dart';
import 'package:oncare/design_system/molecules/section_header.dart';

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(child: SizedBox(width: 300, child: child)),
      ),
    ),
  );
}

void main() {
  testWidgets('MetricCard shows title, value, unit and delta', (t) async {
    await _pump(
      t,
      const MetricCard(
        title: 'Calories',
        value: '1420',
        unit: 'kcal',
        delta: '+12%',
        deltaTone: MetricDeltaTone.positive,
        icon: Icons.restaurant,
      ),
    );
    expect(find.text('Calories'), findsOneWidget);
    expect(find.text('1420'), findsOneWidget);
    expect(find.text('kcal'), findsOneWidget);
    expect(find.text('+12%'), findsOneWidget);
  });

  testWidgets('ChartCard shows title and child', (t) async {
    await _pump(
      t,
      const ChartCard(title: 'Weekly', height: 80, child: SizedBox.shrink()),
    );
    expect(find.text('Weekly'), findsOneWidget);
  });

  testWidgets('SectionHeader renders title + optional action', (t) async {
    await _pump(
      t,
      SectionHeader(
        '오늘',
        action: TextButton(onPressed: () {}, child: const Text('See all')),
      ),
    );
    expect(find.text('오늘'), findsOneWidget);
    expect(find.text('See all'), findsOneWidget);
  });
}
