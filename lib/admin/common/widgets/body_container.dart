import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:npms/admin/pages/patrolHistory/page/patrol_history_page.dart';
import 'package:npms/admin/pages/reports/page/report_page.dart';
import 'package:npms/admin/pages/station/pages/police_station_page.dart';

import '../../dashboard/dashboard.dart';
import '../../pages/officer/page/officer_page.dart';
import '../../pages/qrManagement/pages/qr_management_page.dart';
import '../controller/admin_side_bar_controller.dart';

class BodyContainer extends GetView<AdminLayoutController> {
  const BodyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: SizedBox.expand(
          key: ValueKey(controller.selectedMenu.value),
          child: _getPage(controller.selectedMenu.value),
        ),
      ),
    );
  }

  Widget _getPage(AdminMenu menu) {
    switch (menu) {
      case AdminMenu.dashboard:
        return const DashboardPage(
          key: ValueKey("dashboard"),
        );

      case AdminMenu.qrManagement:
        return const QrManagementPage(
          key: ValueKey("qrManagement"),
        );

      case AdminMenu.policeStation:
        return PoliceStationPage(
          key: ValueKey("policeStation"),
        );


      case AdminMenu.officers:
        return OfficerPage(
          key: ValueKey("Officers"),
        );

     
      case AdminMenu.patrolHistory:
        return PatrolHistoryPage(
           key: ValueKey("Patrol History"),
        );

      case AdminMenu.reports:
        return ReportPage(
           key: ValueKey("Reports"),
        );

      // case AdminMenu.analytics:
      //   return _comingSoon(
      //     "Analytics",
      //     Icons.bar_chart,
      //   );

      // case AdminMenu.notifications:
      //   return _comingSoon(
      //     "Notifications",
      //     Icons.notifications,
      //   );

      case AdminMenu.settings:
        return _comingSoon(
          "Settings",
          Icons.settings,
        );
    }
  }

  Widget _comingSoon(String title, IconData icon) {
    return Container(
      key: ValueKey(title),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.white54,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Coming Soon",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}