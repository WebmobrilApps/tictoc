import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tictoc/utils/color.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ActivityCenterScreen extends StatelessWidget {
  final List<double> orderData; // A list of order data representing daily hours

  ActivityCenterScreen({Key? key, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Center"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daily average screen time",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              "8m",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  maxY: 8.0, // Adjust this based on your data
                  barGroups: _buildBarGroups(),
                  borderData: FlBorderData(
                    border: const Border(
                      left: BorderSide(color: Colors.grey, width: 1),
                      bottom: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  gridData: const FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          // Define the Y-axis labels for 0, 2, 6, and 8 hours
                          switch (value.toInt()) {
                            case 0:
                              return const Text("0h", style: TextStyle(fontSize: 10));
                            case 2:
                              return const Text("2h", style: TextStyle(fontSize: 10));
                            case 4:
                              return const Text("4h", style: TextStyle(fontSize: 10));
                            case 6:
                              return const Text("6h", style: TextStyle(fontSize: 10));
                            case 8:
                              return const Text("8h", style: TextStyle(fontSize: 10));
                            default:
                              return const SizedBox.shrink(); // No label for other values
                          }
                        },
                        reservedSize: 40, // Adjust size for larger labels
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final last7Days = _getLast7Days();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              last7Days[value.toInt()],
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    // Use the provided order data for each day
    final data = [0.0, 0.2, 0.8, 0.1, 0.0, 0.3, 0.2]; // Represents daily hours

  //  final data = orderData.take(7).toList().reversed.toList(); // Last 7 days' data
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            color: Colors.pink,
            width: 21,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
          ),
        ],
      );
    });
  }

  List<String> _getLast7Days() {
    // Get the names of the last 7 days, replacing the current day with "Today"
    final now = DateTime.now();
    return List.generate(7, (index) {
      final day = now.subtract(Duration(days: 6 - index));
      return _formatDay(day, isToday: day.day == now.day);
    });
  }

  String _formatDay(DateTime day, {bool isToday = false}) {
    // Format the day (e.g., "Today" or Mon, Tue)
    if (isToday) return "Today";
    return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][day.weekday % 7];
  }
}


