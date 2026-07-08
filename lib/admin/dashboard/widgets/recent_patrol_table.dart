import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../pages/patrolHistory/widgets/patrol_history_dialog.dart';
import '../controller/admin_dashboard_controller.dart';


class RecentPatrolTable extends GetView<DashboardController> {
  const RecentPatrolTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () {
            final patrols = controller.recentPatrolList;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------------------------------------------------
                // Header
                //------------------------------------------------------

                const Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.indigo,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Recent Patrol History",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //------------------------------------------------------

                if (patrols.isEmpty)
                  const SizedBox(
                    height: 220,
                    child: Center(
                      child: Text(
                        "No Patrol History Available",
                      ),
                    ),
                  )
                else
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor:
                          WidgetStateProperty.all(
                        Colors.grey.shade100,
                      ),

                      columns: const [
                        DataColumn(
                          label: Text("Officer"),
                        ),
                        DataColumn(
                          label: Text("Badge"),
                        ),
                        DataColumn(
                          label: Text("Station"),
                        ),
                        DataColumn(
                          label: Text("Checkpoint"),
                        ),
                        DataColumn(
                          label: Text("Distance"),
                        ),
                        DataColumn(
                          label: Text("Accuracy"),
                        ),
                        DataColumn(
                          label: Text("Patrol Time"),
                        ),
                        // DataColumn(
                        //   label: Text("Status"),
                        // ),
                        DataColumn(
                          label: Text("Action"),
                        ),
                      ],

                      rows: patrols.map((patrol) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                patrol.officerName,
                              ),
                            ),

                            DataCell(
                              Text(
                                patrol.badgeId,
                              ),
                            ),

                            DataCell(
                              Text(
                                patrol.stationName,
                              ),
                            ),

                            DataCell(
                              Text(
                                patrol.checkpointName,
                              ),
                            ),

                            DataCell(
                              Text(
                                "${patrol.distance.toStringAsFixed(2)} m",
                              ),
                            ),

                            DataCell(
                              Text(
                                "${patrol.gpsAccuracy.toStringAsFixed(1)} m",
                              ),
                            ),

                            DataCell(
                              Text(
                                patrol.patrolTime == null
                                    ? "-"
                                    : DateFormat(
                                        "dd MMM yyyy\nhh:mm a",
                                      ).format(
                                        patrol.patrolTime!
                                            .toDate(),
                                      ),
                              ),
                            ),

                            // DataCell(
                            //   Chip(
                            //     backgroundColor:
                            //         patrol.status ==
                            //                 "completed"
                            //             ? Colors.green
                            //                 .shade100
                            //             : Colors.orange
                            //                 .shade100,
                            //     label: Text(
                            //       patrol.status
                            //           .toUpperCase(),
                            //       style: TextStyle(
                            //         color:
                            //             patrol.status ==
                            //                     "completed"
                            //                 ? Colors
                            //                     .green
                            //                 : Colors
                            //                     .orange,
                            //         fontWeight:
                            //             FontWeight
                            //                 .bold,
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            DataCell(
                              IconButton(
                                icon: const Icon(
                                  Icons.visibility,
                                  color:
                                      Colors.indigo,
                                ),
                                onPressed: () {
                                  Get.dialog(
                                    PatrolHistoryDialog(
                                      patrol:
                                          patrol,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}