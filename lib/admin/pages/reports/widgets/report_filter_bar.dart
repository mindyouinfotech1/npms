import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/app_search_bar.dart';
import '../controller/report_controller.dart';

class ReportFilterBar extends GetView<ReportController> {
  const ReportFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < 900;

    return Card(
      color: const Color(0xff14264D),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Obx(
          () => isMobile
              ? _mobileLayout(context)
              : _desktopLayout(context),
        ),
      ),
    );
  }

  //----------------------------------------------------------
  // Desktop
  //----------------------------------------------------------

  Widget _desktopLayout(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: AppSearchBar(
            hintText: "Search Station...",
            onChanged: (value) {
              controller.search.value = value;
            },
          ),
        ),

        _stationDropdown(),

        _quickFilter(),

        _dateRange(context),

        ElevatedButton.icon(
          onPressed: controller.refresh,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          icon: const Icon(Icons.refresh),
          label: const Text("Refresh"),
        ),

        ElevatedButton.icon(
          onPressed: controller.exportExcel,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          icon: const Icon(Icons.download),
          label: const Text("Excel"),
        ),
      ],
    );
  }

  //----------------------------------------------------------
  // Mobile
  //----------------------------------------------------------

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        AppSearchBar(
          hintText: "Search Station...",
          onChanged: (value) {
            controller.search.value = value;
          },
        ),

        const SizedBox(height: 15),

        _stationDropdown(),

        const SizedBox(height: 15),

        _quickFilter(),

        const SizedBox(height: 15),

        _dateRange(context),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: controller.refresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                icon: const Icon(Icons.refresh),
                label: const Text("Refresh"),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: ElevatedButton.icon(
                onPressed: controller.exportExcel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                icon: const Icon(Icons.download),
                label: const Text("Excel"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //----------------------------------------------------------
  // Station
  //----------------------------------------------------------

  Widget _stationDropdown() {
  return Obx(
    () => SizedBox(
      width: 220,
      child: DropdownButtonFormField<String>(
        value: controller.selectedStationId.value.isEmpty
            ? ""
            : controller.selectedStationId.value,
        dropdownColor: const Color(0xff14264D),
        decoration: const InputDecoration(
          labelText: "Station",
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(color: Colors.white),
        items: [
          const DropdownMenuItem(
            value: "",
            child: Text("All Stations"),
          ),

          ...controller.stations.map(
            (station) => DropdownMenuItem(
              value: station.id,
              child: Text(station.stationName),
            ),
          ),
        ],
        onChanged: (value) async {
          controller.selectedStationId.value = value ?? "";
          await controller.loadReports();
        },
      ),
    ),
  );
}

  //----------------------------------------------------------
  // Quick Filter
  //----------------------------------------------------------

  Widget _quickFilter() {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField<String>(
        value: controller.selectedFilter.value,
        dropdownColor: const Color(0xff14264D),
        decoration: const InputDecoration(
          labelText: "Date Filter",
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(color: Colors.white),
        items: const [
          DropdownMenuItem(
            value: "Today",
            child: Text("Today"),
          ),
          DropdownMenuItem(
            value: "Yesterday",
            child: Text("Yesterday"),
          ),
          DropdownMenuItem(
            value: "Last 7 Days",
            child: Text("Last 7 Days"),
          ),
          DropdownMenuItem(
            value: "Last 30 Days",
            child: Text("Last 30 Days"),
          ),
        ],
        onChanged: (value) async {
          switch (value) {
            case "Today":
              await controller.today();
              break;

            case "Yesterday":
              await controller.yesterday();
              break;

            case "Last 7 Days":
              await controller.last7Days();
              break;

            case "Last 30 Days":
              await controller.last30Days();
              break;
          }
        },
      ),
    );
  }

  //----------------------------------------------------------
  // Date Range
  //----------------------------------------------------------

  Widget _dateRange(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        final range = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2024),
          lastDate: DateTime.now(),
        );

        if (range != null) {
          await controller.customDate(
            from: range.start,
            to: range.end,
          );
        }
      },
      icon: const Icon(Icons.date_range),
      label: Text(
        controller.fromDate.value == null
            ? "Custom Date"
            : "${DateFormat('dd MMM').format(controller.fromDate.value!)} - ${DateFormat('dd MMM').format(controller.toDate.value!)}",
      ),
    );
  }
}