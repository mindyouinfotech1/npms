import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../mobile/home/model/patrol_model.dart';
import '../../pages/officer/model/officer_model.dart';
import '../service/dashboard_service.dart';

class DashboardController extends GetxController {
  final DashboardService service =
      DashboardService();

  //----------------------------------------------------------
  // Loading
  //----------------------------------------------------------

  final loading = false.obs;

  //----------------------------------------------------------
  // Dashboard Counts
  //----------------------------------------------------------

  final totalOfficers = 0.obs;
  final totalStations = 0.obs;
  final totalCheckpoints = 0.obs;
  final totalPatrols = 0.obs;
  final todayPatrols = 0.obs;

  //----------------------------------------------------------
  // Recent Data
  //----------------------------------------------------------

  final recentPatrolList =
      <PatrolHistoryModel>[].obs;

  final recentOfficerList =
      <OfficerModel>[].obs;

  //----------------------------------------------------------
  // Init
  //----------------------------------------------------------

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  //----------------------------------------------------------
  // Load Dashboard
  //----------------------------------------------------------

  Future<void> loadDashboard() async {
    loading(true);

    try {
      final results = await Future.wait([
        service.totalOfficers(),
        service.totalStations(),
        service.totalCheckpoints(),
        service.totalPatrols(),
        service.todayPatrols(),
        service.recentPatrols(),
        service.recentOfficers(),
        service.weeklyPatrols(), 
      ]);

      totalOfficers.value = results[0] as int;
      totalStations.value = results[1] as int;
      totalCheckpoints.value = results[2] as int;
      totalPatrols.value = results[3] as int;
      todayPatrols.value = results[4] as int;

      recentPatrolList.assignAll(
        results[5] as List<PatrolHistoryModel>,
      );

      recentOfficerList.assignAll(
        results[6] as List<OfficerModel>,
      );

      weeklyPatrols.assignAll(
      results[7] as List<WeeklyPatrolModel>,
    );

      
     } catch (e, stack) {
    debugPrint("========== DASHBOARD ERROR ==========");
    debugPrint("Error: ${e.toString()}");
    debugPrint("Stack:");
    debugPrint(stack.toString());
    debugPrint("====================================");

    Get.snackbar(
      "Dashboard Error",
      e.toString(),
    );
  } finally {
    loading(false);
  }
  }

  //----------------------------------------------------------
  // Refresh
  //----------------------------------------------------------

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }

  //----------------------------------------------------------
// Weekly Patrol Graph
//----------------------------------------------------------

final weeklyPatrols = <WeeklyPatrolModel>[].obs;

int get maxWeeklyPatrol {
  if (weeklyPatrols.isEmpty) {
    return 1;
  }

  return weeklyPatrols
      .map((e) => e.count)
      .reduce((a, b) => a > b ? a : b);
}


  
}

class WeeklyPatrolModel {
  final String day;
  final int count;

  WeeklyPatrolModel({
    required this.day,
    required this.count,
  });
}

