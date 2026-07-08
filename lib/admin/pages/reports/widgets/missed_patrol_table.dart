import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/app_data_table.dart';
import '../../../common/widgets/app_data_table_row.dart';
import '../../../common/widgets/app_table_header.dart';
import '../controller/report_controller.dart';

class MissedPatrolTable extends GetView<ReportController> {
  const MissedPatrolTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controller.missedPatrols;

      return Column(
        children: [

          //----------------------------------------------------
          // Header
          //----------------------------------------------------

          AppTableHeader(
            title:
                "Missed Patrol Points (${list.length})",
          ),

          //----------------------------------------------------

          Expanded(
            child: AppDataTable(
              columns: _columns,
              rows: List.generate(
                list.length,
                (index) {
                  final item = list[index];

                  return AppDataTableRow.build(
                    index: index + 1,
                    cells: [

                      Text(item.stationName),

                      Text(item.checkpointName),

                      Text(item.qrId),

                      Text(item.priority),

                      Text(
                        item.officerName.isEmpty
                            ? "-"
                            : item.officerName,
                      ),

                      const Chip(
                        backgroundColor:
                            Colors.redAccent,
                        label: Text(
                          "MISSED",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          controller
                              .viewMissedCheckpoint(
                                  item);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  //----------------------------------------------------------

  List<DataColumn2> get _columns => const [

        DataColumn2(
          label: Text("Station"),
          size: ColumnSize.L,
        ),

        DataColumn2(
          label: Text("Checkpoint"),
          size: ColumnSize.L,
        ),

        DataColumn2(
          label: Text("QR ID"),
          size: ColumnSize.M,
        ),

        DataColumn2(
          label: Text("Priority"),
          size: ColumnSize.S,
        ),

        DataColumn2(
          label: Text("Assigned Officer"),
          size: ColumnSize.L,
        ),

        DataColumn2(
          label: Text("Status"),
          size: ColumnSize.S,
        ),

        DataColumn2(
          label: Text("Action"),
          fixedWidth: 100,
        ),
      ];
}