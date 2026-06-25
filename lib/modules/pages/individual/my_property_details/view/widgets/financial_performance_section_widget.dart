// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import '../../../../../../config/theme/app_theme_colors.dart';
// import '../../../../../../core/utils/constants/app_colors.dart';
// import '../../../../../../core/utils/constants/app_constant.dart';
// import '../../../../../../core/utils/constants/app_strings.dart';
// import '../../../../../../core/utils/functions/responsive.dart';
// import '../../model/property_details_model.dart';

// class FinancialPerformanceSectionWidget extends StatelessWidget {
//   const FinancialPerformanceSectionWidget({super.key, required this.property});

//   final PropertyDetailsModel? property;

//   @override
//   Widget build(BuildContext context) {
//     final colors = AppThemeColors.of(context);
//     return Container(
//       padding: EdgeInsets.all(16.width),
//       decoration: BoxDecoration(
//         color: colors.cardBackground,
//         borderRadius: BorderRadius.circular(16.radius),
//         border: Border.all(color: colors.borderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             AppStrings.financialPerformance,
//             style: TextStyle(
//               fontSize: context.responsiveFontScale(16),
//               fontWeight: FontWeight.w700,
//               fontFamily: AppConstant.appHeaderFont,
//               color: colors.textFieldTitle,
//             ),
//           ),
//           SizedBox(height: 12.height),
//           Row(
//             children: [
//               Expanded(
//                 child: FinancialStatCardWidget(
//                   label: AppStrings.income,
//                   amount: property?.totalIncome ?? 0,
//                   color: AppColors.successColor,
//                 ),
//               ),
//               SizedBox(width: 8.width),
//               Expanded(
//                 child: FinancialStatCardWidget(
//                   label: AppStrings.expenses,
//                   amount: property?.totalExpenses ?? 0,
//                   color: const Color(0xFFE53935),
//                 ),
//               ),
//               SizedBox(width: 8.width),
//               Expanded(
//                 child: FinancialStatCardWidget(
//                   label: AppStrings.netProfit,
//                   amount: property?.netProfit ?? 0,
//                   color: colors.primaryBrand,
//                   isLight: true,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.height),
//           SizedBox(
//             height: 160.height,
//             child: FinancialLineChartWidget(data: property?.monthlyFinancials ?? []),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FinancialStatCardWidget extends StatelessWidget {
//   const FinancialStatCardWidget({
//     super.key,
//     required this.label,
//     required this.amount,
//     required this.color,
//     this.isLight = false,
//   });

//   final String label;
//   final double amount;
//   final Color color;
//   final bool isLight;

//   @override
//   Widget build(BuildContext context) {
//     final colors = AppThemeColors.of(context);
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 10.height),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: isLight ? 0.08 : 0.12),
//         borderRadius: BorderRadius.circular(12.radius),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: context.responsiveFontScale(12),
//               color: colors.textSecondary,
//               fontFamily: AppConstant.appFont,
//             ),
//           ),
//           SizedBox(height: 4.height),
//           Text(
//             '${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} ${AppStrings.currency}',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: context.responsiveFontScale(12),
//               fontWeight: FontWeight.w700,
//               fontFamily: AppConstant.appHeaderFont,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FinancialLineChartWidget extends StatelessWidget {
//   const FinancialLineChartWidget({super.key, required this.data});

//   final List<FinancialMonthData> data;

//   @override
//   Widget build(BuildContext context) {
//     final colors = AppThemeColors.of(context);
//     final incomeSpots = data
//         .asMap()
//         .entries
//         .map((e) => FlSpot(e.key.toDouble(), e.value.income))
//         .toList();
//     final expenseSpots = data
//         .asMap()
//         .entries
//         .map((e) => FlSpot(e.key.toDouble(), e.value.expenses))
//         .toList();
//     return LineChart(
//       LineChartData(
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: false,
//           getDrawingHorizontalLine: (_) =>
//               FlLine(color: colors.borderColor, strokeWidth: 1),
//         ),
//         borderData: FlBorderData(show: false),
//         titlesData: FlTitlesData(
//           rightTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 36,
//               getTitlesWidget: (value, meta) => Text(
//                 value.toInt().toString(),
//                 style: TextStyle(
//                   fontSize: context.responsiveFontScale(10),
//                   color: colors.textSecondary,
//                   fontFamily: AppConstant.appFont,
//                 ),
//               ),
//             ),
//           ),
//           leftTitles:
//               const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           topTitles:
//               const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 22,
//               getTitlesWidget: (value, meta) {
//                 final idx = value.toInt();
//                 if (idx < 0 || idx >= data.length) {
//                   return const SizedBox.shrink();
//                 }
//                 return Text(
//                   data[idx].month,
//                   style: TextStyle(
//                     fontSize: context.responsiveFontScale(10),
//                     color: colors.textSecondary,
//                     fontFamily: AppConstant.appFont,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: incomeSpots,
//             isCurved: true,
//             color: const Color(0xFFFFC107),
//             barWidth: 2.5,
//             dotData: const FlDotData(show: false),
//             belowBarData: BarAreaData(
//               show: true,
//               color: const Color(0xFFFFC107).withValues(alpha: 0.08),
//             ),
//           ),
//           LineChartBarData(
//             spots: expenseSpots,
//             isCurved: true,
//             color: colors.primaryBrand.withValues(alpha: 0.4),
//             barWidth: 2,
//             dotData: const FlDotData(show: false),
//             dashArray: [4, 4],
//           ),
//         ],
//       ),
//     );
//   }
// }
