import 'package:crypto_app/services/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

LineChartData chart(
  bool isHomePage,
  List<FlSpot> spots,
  List<DailyDatum> dailyData,
  double minY,
  double maxY,
  bool profit,
  String type,
) {
  List<Color> greenColors = [
    Colors.green.shade900,
    Colors.green.shade700,
  ];
  List<Color> redColors = [
    Colors.red.shade900,
    Colors.red.shade700,
  ];
  dailyData = dailyData.reversed.toList();

  return LineChartData(
    backgroundColor: Colors.black,
    gridData: FlGridData(
      show: !isHomePage,
      drawVerticalLine: !isHomePage,
      drawHorizontalLine: true,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: isHomePage
        ? FlTitlesData(show: false)
        : FlTitlesData(
            show: true,
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              rotateAngle: -20,
              textAlign: TextAlign.center,
              getTextStyles: (context, value) => TextStyle(
                color: const Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              getTitles: (value) {
                // if (type == 'daily') {
                  var date = dailyData[value.toInt()].date.split('-');
                  return dateToMonth(date[2], date[1]);
                // }
                // return '';

                // switch (value.toInt()) {
                //   case 0:
                //     return '1';
                //   case 1:
                //     return '2';
                //   case 2:
                //     return '3';
                //   case 3:
                //     return '4';
                //   case 4:
                //     return '5';
                //   case 5:
                //     return '6';
                //   case 6:
                //     return '7';
                //   case 7:
                //     return '8';
                //   case 8:
                //     return '9';
                //   case 9:
                //     return '10';
                //   default:
                //     return '';
                // }
              },
              margin: 8,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              margin: 10,
              getTextStyles: (context, value) => TextStyle(
                color: const Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              return LineTooltipItem(
                flSpot.y
                    .toStringAsFixed(2)
                    .replaceFirst('.', ',')
                    .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.'),
                GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  letterSpacing: 0.5,
                ),
              );
            }).toList();
          }),
    ),
    minX: 0,
    maxX: 9,
    // minY: minY,
    // maxY: maxY,
    lineBarsData: [
      LineChartBarData(
        spots: spots,
        isCurved: true,
        colors: profit ? greenColors : redColors,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: profit
              ? greenColors.map((color) => color.withOpacity(0.3)).toList()
              : redColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}

String dateToMonth(String date, String month) {
  String dateAndMonth = '';
  month = numToMonth(month);
  if (date[0] == '0') {
    dateAndMonth = date[1] + '\n' + month;
  } else {
    dateAndMonth = date + '\n' + month;
  }
  return dateAndMonth;
}

String numToMonth(String month) {
  switch (month) {
    case '01':
      month = 'Jan';
      break;
    case '02':
      month = 'Feb';
      break;
    case '03':
      month = 'Mar';
      break;
    case '04':
      month = 'Apr';
      break;
    case '05':
      month = 'May';
      break;
    case '06':
      month = 'Jun';
      break;
    case '07':
      month = 'Jul';
      break;
    case '08':
      month = 'Aug';
      break;
    case '09':
      month = 'Sep';
      break;
    case '10':
      month = 'Oct';
      break;
    case '11':
      month = 'Nov';
      break;
    case '12':
      month = 'Dec';
      break;
    default:
      month = '';
  }
  return month;
}
