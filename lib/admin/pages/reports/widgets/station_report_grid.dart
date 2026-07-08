import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/report_controller.dart';
import 'station_report_card.dart';

class StationReportGrid extends GetView<ReportController> {
  const StationReportGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (controller.stationReports.isEmpty) {
        return Container(
          height: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xff14264D),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.analytics_outlined,
                size: 70,
                color: Colors.white38,
              ),
              SizedBox(height: 15),
              Text(
                "No Report Available",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = 350;

          if (constraints.maxWidth < 700) {
            cardWidth = constraints.maxWidth;
          } else if (constraints.maxWidth < 1100) {
            cardWidth = (constraints.maxWidth - 20) / 2;
          } else if (constraints.maxWidth < 1600) {
            cardWidth = (constraints.maxWidth - 40) / 3;
          } else {
            cardWidth = (constraints.maxWidth - 60) / 4;
          }

          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: controller.filteredStations.map((report) {
              return SizedBox(
                width: cardWidth,
                child: StationReportCard(
                  report: report,
                  onView: () {
                    controller.viewStationReport(report);
                  },
                ),
              );
            }).toList(),
          );
        },
      );
    });
  }
}