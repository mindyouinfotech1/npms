import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:npms/admin/pages/reports/widgets/station_detail_dialog.dart';
import 'package:npms/admin/pages/station/services/police_station_service.dart';

import '../../station/model/police_station_model.dart';
import '../model/missed_patrol_model.dart';
import '../model/officer_report_model.dart';
import '../model/station_report_model.dart';
import '../service/report_service.dart';
import '../widgets/missed_patrol_dialog.dart';

class ReportController extends GetxController {
  final ReportService service = ReportService();
  final missedPatrols = <MissedPatrolModel>[].obs;
  final PoliceStationService stationService =
    Get.find<PoliceStationService>();

final stations = <PoliceStationModel>[].obs;

  //----------------------------------------------------------
  // Loading
  //----------------------------------------------------------

  final loading = false.obs;

  //----------------------------------------------------------
  // Filters
  //----------------------------------------------------------

  final selectedStationId = "".obs;

  final search = "".obs;

  final fromDate = Rxn<DateTime>();

  final toDate = Rxn<DateTime>();

  final selectedFilter = "Today".obs;

  //----------------------------------------------------------
  // Data
  //----------------------------------------------------------

  final stationReports =
      <StationReportModel>[].obs;

  final officerReports =
      <OfficerReportModel>[].obs;

  //----------------------------------------------------------
  // Summary
  //----------------------------------------------------------

  final totalStations = 0.obs;

  final totalQrPoints = 0.obs;

  final totalVisited = 0.obs;

  final totalMissed = 0.obs;

  final totalPatrols = 0.obs;

  final compliance = 0.0.obs;

  //----------------------------------------------------------
  // Init
  //----------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

     today();
     loadStations();

   debounce(
  search,
  (_) {
    update();
  },
);
  }

  void viewStationReport(
  StationReportModel report,
) {
  Get.dialog(
    StationDetailDialog(
      report: report,
    ),
    barrierDismissible: true,
  );
}


Future<void> loadStations() async {
  try {
    final list = await stationService.getStations().first;
    stations.assignAll(list);
  } catch (e) {
    debugPrint(e.toString());
  }
}

  void viewMissedCheckpoint(MissedPatrolModel checkpoint) {
  Get.dialog(
    MissedPatrolDialog(
      checkpoint: checkpoint,
    ),
  );
}

  //----------------------------------------------------------
  // Load Reports
  //----------------------------------------------------------

 Future<void> loadReports() async {
  loading(true);

  try {
    debugPrint("=========== REPORT START ===========");
    debugPrint("Station Filter : ${selectedStationId.value}");
    debugPrint("From Date      : ${fromDate.value}");
    debugPrint("To Date        : ${toDate.value}");
    

    final stationData = await service.stationReport(
      stationId: selectedStationId.value,
      from: fromDate.value,
      to: toDate.value,
    );

    debugPrint("Station Reports : ${stationData.length}");

    for (final item in stationData) {
      debugPrint(
        "Station: ${item.stationName}"
        " | QR: ${item.totalQrPoints}"
        " | Visited: ${item.visitedQrPoints}"
        " | Missed: ${item.missedQrPoints}"
        " | Patrols: ${item.totalPatrols}"
        " | Compliance: ${item.compliance}",
      );
    }

    final officerData = await service.officerReport(
      stationId: selectedStationId.value,
      from: fromDate.value,
      to: toDate.value,
    );

    debugPrint("Officer Reports : ${officerData.length}");

    for (final item in officerData) {
      debugPrint(
        "Officer: ${item.officerName}"
        " | Station: ${item.stationName}"
        " | Assigned: ${item.assignedQrPoints}"
        " | Visited: ${item.visitedQrPoints}"
        " | Missed: ${item.missedQrPoints}"
        " | Compliance: ${item.compliance}",
      );
    }

    stationReports.assignAll(stationData);
    officerReports.assignAll(officerData);

    _calculateSummary();
    debugPrint("Station Reports Loaded: ${stationReports.length}");

    debugPrint("----------- SUMMARY -----------");
    debugPrint("Total Stations : ${totalStations.value}");
    debugPrint("Total QR       : ${totalQrPoints.value}");
    debugPrint("Visited        : ${totalVisited.value}");
    debugPrint("Missed         : ${totalMissed.value}");
    debugPrint("Total Patrols  : ${totalPatrols.value}");
    debugPrint("Compliance     : ${compliance.value}");
    debugPrint("=========== REPORT END ===========");
  } catch (e, stack) {
    debugPrint("=========== REPORT ERROR ===========");
    debugPrint(e.toString());
    debugPrint(stack.toString());

    Get.snackbar(
      "Report Error",
      e.toString(),
    );
  } finally {
    loading(false);
  }
}

  //----------------------------------------------------------
  // Summary
  //----------------------------------------------------------

  void _calculateSummary() {
  debugPrint("========= SUMMARY =========");

  debugPrint("Reports: ${stationReports.length}");

  totalStations.value = stationReports.length;

  totalQrPoints.value = stationReports.fold(
    0,
    (sum, e) => sum + e.totalQrPoints,
  );

  totalVisited.value = stationReports.fold(
    0,
    (sum, e) => sum + e.visitedQrPoints,
  );

  totalMissed.value = stationReports.fold(
    0,
    (sum, e) => sum + e.missedQrPoints,
  );

  totalPatrols.value = stationReports.fold(
    0,
    (sum, e) => sum + e.totalPatrols,
  );

  compliance.value = totalQrPoints.value == 0
      ? 0
      : (totalVisited.value / totalQrPoints.value) * 100;

  debugPrint("Stations : ${totalStations.value}");
  debugPrint("QR : ${totalQrPoints.value}");
  debugPrint("Visited : ${totalVisited.value}");
  debugPrint("Missed : ${totalMissed.value}");
  debugPrint("Compliance : ${compliance.value}");
}

  //----------------------------------------------------------
  // Search
  //----------------------------------------------------------

  List<StationReportModel>
      get filteredStations {
    if (search.value.isEmpty) {
      return stationReports;
    }

    return stationReports.where((e) {
      return e.stationName
          .toLowerCase()
          .contains(
            search.value.toLowerCase(),
          );
    }).toList();
  }

  List<OfficerReportModel>
      get filteredOfficers {
    if (search.value.isEmpty) {
      return officerReports;
    }

    return officerReports.where((e) {
      return e.officerName
              .toLowerCase()
              .contains(
                search.value.toLowerCase(),
              ) ||
          e.badgeId
              .toLowerCase()
              .contains(
                search.value.toLowerCase(),
              );
    }).toList();
  }

  //----------------------------------------------------------
  // Filter Buttons
  //----------------------------------------------------------

  Future<void> today() async {
    final now = DateTime.now();

    fromDate.value =
        DateTime(now.year, now.month, now.day);

    toDate.value = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
    );

    selectedFilter.value = "Today";

    await loadReports();
  }

  Future<void> yesterday() async {
    final day =
        DateTime.now().subtract(
      const Duration(days: 1),
    );

    fromDate.value =
        DateTime(day.year, day.month, day.day);

    toDate.value = DateTime(
      day.year,
      day.month,
      day.day,
      23,
      59,
      59,
    );

    selectedFilter.value = "Yesterday";

    await loadReports();
  }

  Future<void> last7Days() async {
    fromDate.value =
        DateTime.now().subtract(
      const Duration(days: 6),
    );

    toDate.value = DateTime.now();

    selectedFilter.value = "Last 7 Days";

    await loadReports();
  }

  Future<void> last30Days() async {
    fromDate.value =
        DateTime.now().subtract(
      const Duration(days: 29),
    );

    toDate.value = DateTime.now();

    selectedFilter.value = "Last 30 Days";

    await loadReports();
  }

  Future<void> customDate({
    required DateTime from,
    required DateTime to,
  }) async {
    fromDate.value = from;

    toDate.value = to;

    selectedFilter.value = "Custom";

    await loadReports();
  }

  //----------------------------------------------------------
  // Reset
  //----------------------------------------------------------

  Future<void> resetFilters() async {
    selectedStationId.value = "";

    search.value = "";

    fromDate.value = null;

    toDate.value = null;

    selectedFilter.value = "Today";

    await today();
  }

  //----------------------------------------------------------
  // Refresh
  //----------------------------------------------------------

  Future<void> refresh() async {
    await loadReports();
  }

  //----------------------------------------------------------
  // Export
  //----------------------------------------------------------

  Future<void> exportExcel() async {
    // Excel Service
  }

  Future<void> exportPdf() async {
    // PDF Service
  }
}