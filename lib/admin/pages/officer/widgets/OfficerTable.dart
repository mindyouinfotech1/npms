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

import '../controller/officer_controller.dart';


class OfficerTable extends GetView<OfficerController> {
  const OfficerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controller.filteredList;

      return Column(
        children: [
          /// Header
          AppTableHeader(
            title: "Police Officers",
            search: AppSearchBar(
              hintText: "Search Officer...",
              onChanged: (value) {
                controller.search.value = value;
              },
            ),
            actions: [
              IconButton(
                tooltip: "Refresh",
                onPressed: controller.loadOfficers,
                icon: const Icon(Icons.refresh,color: Colors.white,),
              ),
            ],
          ),

          Expanded(
            child: AppDataTable(
              columns: _columns,
              rows: List.generate(
                list.length,
                (index) {
                  final officer = list[index];

                  return AppDataTableRow.build(
                    index: ((controller.page.value - 1) *
                            controller.rowsPerPage.value) +
                        index +
                        1,
                    cells: [
                      Text(officer.badgeId),

                      Text(officer.fullName),

                      Text(officer.rank),

                      Text(officer.stationName),

                      Text(officer.mobile),

                      _statusChip(officer.status),

                      AppTableActions(
                        onEdit: () {
                          controller.editOfficer(officer);
                        },
                        onDelete: () {
                          controller.deleteOfficer(officer);
                        },
                        onView: () {
                          _viewOfficer(officer);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          AppTableFooter(
            totalRecords: controller.totalRecords.value,
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

              const SizedBox(width: 10),

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
          label: Text("Badge ID"),
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
          label: Text("Police Station"),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text("Mobile"),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text("Status"),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text("Actions"),
          fixedWidth: 150,
        ),
      ];

  Widget _statusChip(String status) {
    final active = status == "active";

    return Chip(
      backgroundColor:
          active ? Colors.green.shade100 : Colors.red.shade100,
      label: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: active ? Colors.green.shade800 : Colors.red.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _viewOfficer(dynamic officer) {
    Get.dialog(
      AlertDialog(
        title: Text(officer.fullName),
        content: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 45,
                child: Text(
                  officer.fullName.isEmpty
                      ? ""
                      : officer.fullName[0].toUpperCase(),
                  style: const TextStyle(fontSize: 28),
                ),
              ),

              const SizedBox(height: 20),

              ListTile(
                dense: true,
                leading: const Icon(Icons.badge),
                title: const Text("Badge ID"),
                subtitle: Text(officer.badgeId),
              ),

              ListTile(
                dense: true,
                leading: const Icon(Icons.workspace_premium),
                title: const Text("Rank"),
                subtitle: Text(officer.rank),
              ),

              ListTile(
                dense: true,
                leading: const Icon(Icons.local_police),
                title: const Text("Station"),
                subtitle: Text(officer.stationName),
              ),

              ListTile(
                dense: true,
                leading: const Icon(Icons.phone),
                title: const Text("Mobile"),
                subtitle: Text(officer.mobile),
              ),

              ListTile(
                dense: true,
                leading: const Icon(Icons.schedule),
                title: const Text("Shift"),
                subtitle: Text(officer.shift),
              ),
            ],
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