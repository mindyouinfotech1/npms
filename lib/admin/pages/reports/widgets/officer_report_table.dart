import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/app_data_table.dart';
import '../../../common/widgets/app_data_table_row.dart';
import '../../../common/widgets/app_table_header.dart';
import '../controller/report_controller.dart';
import 'officer_detail_dialog.dart';


class OfficerReportTable extends GetView<ReportController> {
  const OfficerReportTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controller.officerReports;

      return Column(
        children: [

          //--------------------------------------------------
          // Header
          //--------------------------------------------------

          const AppTableHeader(
            title: "Officer Patrol Report",
          ),

          //--------------------------------------------------

          Expanded(
            child: AppDataTable(
              columns: _columns,
              rows: List.generate(
                list.length,
                (index) {
                  final officer = list[index];

                  return AppDataTableRow.build(
                    index: index + 1,
                    cells: [

                      Text(officer.badgeId),

                      Text(officer.officerName),

                      Text(officer.rank),

                      Text(officer.stationName),

                     Text(
                      officer.assignedQrPoints.toString(),
                    ),

                    Text(
                      officer.visitedQrPoints.toString(),
                    ),

                    Text(
                      officer.missedQrPoints.toString(),
                    ),

                      _progressChip(
                        officer.compliance,
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.blue,
                        ),
                       onPressed: () {
                        Get.dialog(
                          OfficerDetailDialog(
                            officer: officer,
                          ),
                        );
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
          label: Text("Badge"),
          size: ColumnSize.S,
        ),

        DataColumn2(
          label: Text("Officer"),
          size: ColumnSize.L,
        ),

        DataColumn2(
          label: Text("Rank"),
          size: ColumnSize.M,
        ),

        DataColumn2(
          label: Text("Station"),
          size: ColumnSize.L,
        ),

        DataColumn2(
          label: Text("Assigned"),
          size: ColumnSize.S,
        ),

        DataColumn2(
          label: Text("Visited"),
          size: ColumnSize.S,
        ),

        DataColumn2(
          label: Text("Missed"),
          size: ColumnSize.S,
        ),

        DataColumn2(
          label: Text("Compliance"),
          size: ColumnSize.M,
        ),

        DataColumn2(
          label: Text("Action"),
          fixedWidth: 100,
        ),
      ];

  //----------------------------------------------------------

  Widget _progressChip(double value) {

    Color color;

    if (value >= 90) {
      color = Colors.green;
    } else if (value >= 75) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return SizedBox(
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          LinearProgressIndicator(
            value: value / 100,
            color: color,
            minHeight: 8,
            borderRadius:
                BorderRadius.circular(8),
          ),

          const SizedBox(height: 6),

          Text(
            "${value.toStringAsFixed(1)}%",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}