import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/report_controller.dart';
import '../widgets/report_filter_bar.dart';
import '../widgets/report_summary_cards.dart';
import '../widgets/station_report_grid.dart';

class ReportPage extends GetView<ReportController> {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    
  debugPrint(
      "Page Controller Hash : ${controller.hashCode}");
    final isMobile =
        MediaQuery.of(context).size.width < 700;

   return Container(
  color: Colors.transparent,
  padding: EdgeInsets.all(isMobile ? 16 : 24),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //--------------------------------------------------
        // Header
        //--------------------------------------------------

        if (isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Patrol Monitoring Report",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Station-wise Patrol Compliance Report",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          )
        else
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Patrol Monitoring Report",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Station-wise Patrol Compliance Report",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
            ],
          ),

        const SizedBox(height: 25),

        const ReportFilterBar(),

        const SizedBox(height: 20),

        const ReportSummaryCards(),

        const SizedBox(height: 20),

        Obx(() {
          if (controller.loading.value) {
            return const SizedBox(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (controller.filteredStations.isEmpty) {
            return const SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  "No Report Found",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            );
          }

          return const StationReportGrid();
        }),
      ],
    ),
  ),
);
  }
}