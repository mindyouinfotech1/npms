import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../mobile/home/model/patrol_model.dart';
import '../../../common/widgets/app_data_table.dart';
import '../../../common/widgets/app_data_table_row.dart';
import '../../../common/widgets/app_pagination.dart';
import '../../../common/widgets/app_search_bar.dart';
import '../../../common/widgets/app_table_actions.dart';
import '../../../common/widgets/app_table_footer.dart';
import '../../../common/widgets/app_table_header.dart';

import '../controller/patrol_history_controller.dart';

class PatrolHistoryTable
    extends GetView<PatrolHistoryController> {
  const PatrolHistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controller.paginatedList;

      return Column(
        children: [
          //--------------------------------------------------
          // Header
          //--------------------------------------------------

          AppTableHeader(
            title: "Patrol History",
            search: AppSearchBar(
              hintText: "Search Patrol...",
            onChanged: (value) {
              controller.search.value = value;
              controller.page.value = 1;
            }
            ),
            actions: [
             IconButton(
                onPressed: controller.loadPatrols,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          //--------------------------------------------------
          // Table
          //--------------------------------------------------

          Expanded(
            child: AppDataTable(
              columns: _columns,
              rows: List.generate(
                list.length,
                (index) {
                  final patrol = list[index];

                  return AppDataTableRow.build(
                    index:
                        ((controller.page.value - 1) *
                                controller.rowsPerPage.value) +
                            index +
                            1,
                    cells: [
                      Text(patrol.officerName),

                      Text(patrol.badgeId),

                      Text(patrol.stationName),

                      Text(patrol.checkpointName),

                      Text(
                        "${patrol.distance.toStringAsFixed(2)} m",
                      ),

                      Text(
                        "${patrol.gpsAccuracy.toStringAsFixed(1)} m",
                      ),

                      Text(
                        patrol.patrolTime == null
                            ? "-"
                            : DateFormat(
                            "dd MMM yyyy\nhh:mm a",
                          ).format(
                            patrol.patrolTime!.toDate(),
                          )
                      ),

                      _statusChip(patrol.status),

                      patrol.photoUrl.isEmpty
                          ? const Icon(Icons.image_not_supported)
                          : InkWell(
                              onTap: () =>
                                  _showImage(patrol),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    patrol.photoUrl,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                )
                              ),
                            ),

                      AppTableActions(
                        onView: () =>
                            _viewPatrol(patrol),
                        onDelete: () =>
                            controller.deletePatrol(
                                patrol),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          //--------------------------------------------------
          // Footer
          //--------------------------------------------------

          AppTableFooter(
            totalRecords: controller.filteredList.length,
            pagination: AppPagination(
              page: controller.page.value,
              
            hasPrevious: controller.hasPrevious.value,
            hasNext: controller.hasNext.value,
            onPrevious: controller.previousPage,
            onNext: controller.nextPage,
            ),
            actions: [
              DropdownButton<int>(
                  value: controller.rowsPerPage.value,
                  underline: const SizedBox(),
                  dropdownColor: const Color(0xff14264D),
                  iconEnabledColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 10,
                      child: Text(
                        "10",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 25,
                      child: Text(
                        "25",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 50,
                      child: Text(
                        "50",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 100,
                      child: Text(
                        "100",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.changeRowsPerPage(value);
                    }
                  },
                ),
            ],
          ),
        ],
      );
    });
  }

  //----------------------------------------------------------
  // Columns
  //----------------------------------------------------------

  List<DataColumn2> get _columns => const [
        DataColumn2(
          label: Text("Officer"),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text("Badge"),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text("Station"),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text("Checkpoint"),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text("Distance"),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text("GPS"),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text("Patrol Time"),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text("Status"),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text("Photo"),
          fixedWidth: 80,
        ),
        DataColumn2(
          label: Text("Actions"),
          fixedWidth: 130,
        ),
      ];

  //----------------------------------------------------------

  Widget _statusChip(String status) {
  final completed = status == "completed";

  return Chip(
    backgroundColor: completed
        ? Colors.green.shade100
        : Colors.orange.shade100,
    label: Text(
      status.toUpperCase(),
      style: TextStyle(
        color: completed
            ? Colors.green.shade800
            : Colors.orange.shade800,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

  //----------------------------------------------------------

  void _showImage(
      PatrolHistoryModel patrol) {
    Get.dialog(
      Dialog(
        child: InteractiveViewer(
          child: Image.network(
            patrol.photoUrl,
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------

  void _viewPatrol(
      PatrolHistoryModel patrol) {
    Get.dialog(
      AlertDialog(
        title: const Text("Patrol Details"),
        content: SizedBox(
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                    "Officer : ${patrol.officerName}"),
                Text(
                    "Badge : ${patrol.badgeId}"),
                Text(
                    "Station : ${patrol.stationName}"),
                Text(
                    "Checkpoint : ${patrol.checkpointName}"),
                Text(
                    "Distance : ${patrol.distance.toStringAsFixed(2)} m"),
                Text(
                    "Accuracy : ${patrol.gpsAccuracy.toStringAsFixed(1)} m"),
                const SizedBox(height: 15),
                if (patrol.photoUrl.isNotEmpty)
                  Image.network(
                    patrol.photoUrl,
                    height: 250,
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}