import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Vertically-stacked categorical bar chart. Each x position is a
/// single bar made up of segments (`series`) drawn from bottom up.
/// Series with all-zero values are tolerated and treated as empty
/// slices.
class AppStackedBarChart extends StatelessWidget {
  const AppStackedBarChart({
    required this.series,
    required this.labels,
    super.key,
  });

  /// One entry per stacked layer (e.g. cardio / strength / stretching),
  /// each list the same length as [labels].
  final List<({String name, Color color, List<double> values})> series;

  /// X-axis category labels (e.g. ['월','화','수','목','금','토','일']).
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groupCount = labels.length;
    final maxStack = _maxStackedValue();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxStack == 0 ? 80 : (maxStack * 1.2),
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: theme.dividerColor.withValues(alpha: 0.25)),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: maxStack == 0 ? 20 : null,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value == meta.max) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    value.toInt().toString(),
                    style: theme.textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: (double value, TitleMeta meta) {
                final i = value.toInt();
                if (i < 0 || i >= labels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(labels[i], style: theme.textTheme.bodySmall),
                );
              },
            ),
          ),
        ),
        barGroups: <BarChartGroupData>[
          for (int i = 0; i < groupCount; i++)
            BarChartGroupData(x: i, barRods: <BarChartRodData>[_rodAt(i)]),
        ],
      ),
    );
  }

  BarChartRodData _rodAt(int i) {
    final stackItems = <BarChartRodStackItem>[];
    double cursor = 0;
    for (final s in series) {
      final v = i < s.values.length ? s.values[i] : 0.0;
      if (v <= 0) continue;
      stackItems.add(BarChartRodStackItem(cursor, cursor + v, s.color));
      cursor += v;
    }
    return BarChartRodData(
      toY: cursor,
      width: 18,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      rodStackItems: stackItems,
      // Solid fallback colour used when there are no stack items (all
      // zero day) — keeps the rod invisible rather than drawing a
      // bright default.
      color: Colors.transparent,
    );
  }

  double _maxStackedValue() {
    double m = 0;
    for (int i = 0; i < labels.length; i++) {
      double sum = 0;
      for (final s in series) {
        if (i < s.values.length) sum += s.values[i];
      }
      if (sum > m) m = sum;
    }
    return m;
  }
}
