import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictoc/screens/settings_policies_and_support/terms_and_policies.dart';
import 'package:tictoc/utils/color.dart';
import 'package:tictoc/utils/custom_appbar.dart';
import 'package:tictoc/utils/custom_widgets.dart';
import 'package:velocity_x/velocity_x.dart';
class ActivityCenter extends StatefulWidget {
  const ActivityCenter({super.key});

  @override
  State<ActivityCenter> createState() => _ActivityCenterState();
}

class _ActivityCenterState extends State<ActivityCenter> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: appBgColor,
     appBar: const CustomAppBar(title: "Activity Center"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              largeText16(context, "Daily average screen time",fontSize:18,textColor: appGreyColor,fontWeight: FontWeight.w400),
              largeText16(context, "8m",fontSize:26,fontWeight: FontWeight.w600),
              const SizedBox(height: 20),
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
                    gridData:FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Color(0xffDEDEDE),   // Set the color of horizontal grid lines
                          strokeWidth: 1.0,     // Set the thickness of horizontal grid lines
                          //    dashArray: [60, 4],    // Optional: Add a dashed line style ([dashLength, gapLength])
                        );
                      },
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
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        // tooltipBgColor: Colors.black, // Tooltip background color
                        tooltipPadding: const EdgeInsets.all(8), // Padding inside the tooltip
                        tooltipMargin: 8, // Distance from the bar to the tooltip
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${rod.toY.toStringAsFixed(1)}', // Tooltip text
                            GoogleFonts.jost(
                              color: Colors.white, // Tooltip text color
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      touchCallback: (event, response) {
                        // Optional: Handle touch interaction here
                      },
                      allowTouchBarBackDraw: true,
                    ),
                  ),
                ),
              ),
              const Divider(color: Color(0XFFDEDEDE),thickness: 1,),
              const SizedBox(height: 8),
              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.hourglass_empty, color: Colors.grey),
                      const SizedBox(width: 12,),
                      largeText16(context, 'See all screen time data',fontWeight: FontWeight.w600),
                    ],
                  ),
                  Image.asset(
                    'assets/images/right_arrow_1.png',
                    height: 20,
                    width: 20,
                  ).pOnly(right: 10),
                ],
              ),
              const SizedBox(height: 24),
              RowActivityWidget(labelText: 'Watch history', onTap: (){},),
              RowActivityWidget(labelText: 'Comment history', onTap: (){},),
              RowActivityWidget(labelText: 'Search history', onTap: (){},),
              RowActivityWidget(labelText: 'Mention history', onTap: (){},),
              RowActivityWidget(labelText: 'Account history', onTap: (){},),
              RowActivityWidget(labelText: 'Manage post visibility', onTap: (){},),
              RowActivityWidget(labelText: 'Manage associated videos', onTap: (){},showDivider: false,),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    // Use the provided order data for each day
    // final data = orderData.take(7).toList().reversed.toList(); // Last 7 days' data
    final data = [1.2, 0.4, 4.3, 0.1, 2.0, 6.5, 0.7].take(7).toList().reversed.toList(); // Last 7 days' data
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            color: Colors.red,
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

class RowActivityWidget extends StatelessWidget {
  final String labelText;
  final VoidCallback? onTap;
  final bool showDivider;


  const RowActivityWidget({
    super.key,
    required this.labelText,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8,),
        MyInkWell(
          onTap: ()async{
            onTap!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mediumText14(context,labelText,fontWeight:FontWeight.w500,
                  textColor: const Color(0xff404040)).pOnly(left: 14),
              Image.asset(
                'assets/images/right_arrow_1.png',
                height: 20,
                width: 20,
              ).pOnly(right: 10),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        if(showDivider)
          const Divider(color: Color(0xffDEDEDE),thickness: 1,),
      ],
    );
  }
}