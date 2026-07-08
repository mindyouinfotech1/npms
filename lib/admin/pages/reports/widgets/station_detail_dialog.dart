import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/station_report_model.dart';

class StationDetailDialog extends StatelessWidget {
  final StationReportModel report;

  const StationDetailDialog({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      backgroundColor: const Color(0xff14264D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        width: 1200,
        height: 720,
        child: Column(
          children: [

            //--------------------------------------------------
            // Header
            //--------------------------------------------------

            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xff081A3A),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
              ),
              child: Row(
                children: [

                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.account_balance,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          report.stationName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "${report.visitedQrPoints}/${report.totalQrPoints} QR Points Visited",
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: Get.back,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            //--------------------------------------------------
            // Summary
            //--------------------------------------------------

            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [

                  Expanded(
                    child: _summary(
                      "QR Points",
                      report.totalQrPoints.toString(),
                      Colors.orange,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _summary(
                      "Visited",
                      report.visitedQrPoints.toString(),
                      Colors.green,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _summary(
                      "Missed",
                      report.missedQrPoints.toString(),
                      Colors.red,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _summary(
                      "Compliance",
                      "${report.compliance.toStringAsFixed(1)} %",
                      Colors.cyan,
                    ),
                  ),
                ],
              ),
            ),

            //--------------------------------------------------
            // Table
            //--------------------------------------------------

            Expanded(
              child: report.details.isEmpty
                  ? const Center(
                      child: Text(
                        "No Patrol Found",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: DataTable(
                        headingRowColor:
                            WidgetStateProperty.all(
                          Colors.black26,
                        ),

                        columns: const [

                          DataColumn(
                            label: Text(
                              "Checkpoint",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Officer",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Badge",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Visited At",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Distance",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "GPS",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Status",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),
                        ],

                        rows: report.details.map((e) {

                          return DataRow(
                            cells: [

                              DataCell(
                                Text(
                                  e.checkpointName,
                                  style: const TextStyle(
                                      color:
                                          Colors.white),
                                ),
                              ),

                              DataCell(
                                Text(
                                  e.officerName,
                                  style: const TextStyle(
                                      color:
                                          Colors.white),
                                ),
                              ),

                              DataCell(
                                Text(
                                  e.badgeId,
                                  style: const TextStyle(
                                      color:
                                          Colors.white),
                                ),
                              ),

                              DataCell(
                                Text(
                                  DateFormat(
                                    "dd MMM yyyy HH:mm",
                                  ).format(
                                    e.patrolTime!
                                        .toDate(),
                                  ),
                                  style: const TextStyle(
                                      color:
                                          Colors.white),
                                ),
                              ),

                              DataCell(
                                Text(
                                  "${e.distance.toStringAsFixed(2)} m",
                                  style: const TextStyle(
                                      color:
                                          Colors.white),
                                ),
                              ),

                              DataCell(
                                Text(
                                  "${e.gpsAccuracy.toStringAsFixed(1)} m",
                                  style: const TextStyle(
                                      color:
                                          Colors.white),
                                ),
                              ),

                              DataCell(
                                Chip(
                                  backgroundColor:
                                      Colors.green
                                          .shade100,
                                  label: const Text(
                                    "Visited",
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),

            //--------------------------------------------------
            // Footer
            //--------------------------------------------------

           Padding(
  padding: const EdgeInsets.all(20),
  child: Wrap(
    alignment: WrapAlignment.spaceBetween,
    runSpacing: 10,
    spacing: 10,
    children: [
      ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.download),
        label: const Text("Excel Report"),
      ),

      OutlinedButton(
        onPressed: () => Get.back(),
        child: const Text("Close"),
      ),
    ],
  ),
),
          ],
        ),
      ),
    );
  }

  Widget _summary(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.04),
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Column(
        children: [

          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}