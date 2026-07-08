import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/app_data_table.dart';
import '../../../common/widgets/app_data_table_row.dart';
import '../../../common/widgets/app_pagination.dart';
import '../../../common/widgets/app_search_bar.dart';
import '../../../common/widgets/app_table_actions.dart';
import '../../../common/widgets/app_table_footer.dart';
import '../../../common/widgets/app_table_header.dart';
import '../controller/qr_management_controller.dart';
import 'priority_chip.dart';

class QrTable extends GetView<QrManagementController> {
  const QrTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      final list = controller.paginatedList;

      return Column(
        children: [

          /// Header
          AppTableHeader(
            title: "QR Checkpoints",
            search: AppSearchBar(
              hintText: "Search Checkpoint...",
              onChanged: (value) {
                controller.search.value = value;
                controller.page.value = 1;
              },
            ),
            // actions: [
            //   IconButton(
            //     onPressed: controller.loadCheckpoints,
            //     icon: const Icon(Icons.refresh,color: Colors.white,),
            //   ),
            // ],
          ),

         Expanded(
  child: AppDataTable(
    columns: _columns,
    rows: List.generate(
  list.length,
  (index) {
    final checkpoint = list[index];

    return AppDataTableRow.build(
      index: ((controller.page.value - 1) *
              controller.rowsPerPage.value) +
          index +
          1,
      cells: [
        Text(checkpoint.qrId),
        Text(checkpoint.checkpointName),
        Text(checkpoint.stationName),

        PriorityChip(
          priority: checkpoint.priority,
        ),

        Chip(
          label: Text(checkpoint.status.toUpperCase()),
        ),

        AppTableActions(
          onView: () => controller.viewQr(checkpoint),
          onEdit: () => controller.editCheckpoint(checkpoint),
          onDelete: () => controller.deleteCheckpoint(checkpoint),
        ),
      ],
    );
  },
).toList(),
  ),
),

// AppTableFooter(
//   totalRecords: controller.filteredList.length,
//   pagination: AppPagination(
//     currentPage: controller.page.value,
//     totalPages: controller.totalPages,
//     rowsPerPage: controller.rowsPerPage.value,
//     onNext: controller.nextPage,
//     onPrevious: controller.previousPage,
//     onRowsPerPageChanged: controller.changeRowsPerPage,
//   ),
// ),

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

              const SizedBox(width: 15),

              // ElevatedButton.icon(
              //   onPressed: controller.exportExcel,
              //   icon: const Icon(Icons.table_chart),
              //   label: const Text("Excel"),
              // ),

              // const SizedBox(width: 10),

              // ElevatedButton.icon(
              //   onPressed: controller.exportPdf,
              //   icon: const Icon(Icons.picture_as_pdf),
              //   label: const Text("PDF"),
              // ),
            ],
          ),
        ],
      );
    });
  }

  List<DataColumn2> get _columns => const [
    
  DataColumn2(
    label: Text("QR ID"),
    size: ColumnSize.S,
  ),
  DataColumn2(
    label: Text("Checkpoint"),
    size: ColumnSize.L,
  ),
  DataColumn2(
    label: Text("Police Station"),
    size: ColumnSize.L,
  ),
  DataColumn2(
    label: Text("Priority"),
  ),
  DataColumn2(
    label: Text("Status"),
  ),
  DataColumn2(
    label: Text("Actions"),
    fixedWidth: 150,
  ),
];
}