import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/admin_dashboard_controller.dart';
import 'widgets/dashbaord_cards.dart';
import 'widgets/dashboard_patrol_chart.dart';
import 'widgets/officer_status_card.dart';
import 'widgets/recent_patrol_table.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DashboardColors.background,
      body: RefreshIndicator(
          onRefresh: controller.refreshDashboard,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
          children: [

            //  DashboardHeader(),

            SizedBox(height:20),

            DashboardCards(),

            SizedBox(height:20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  flex:2,
                  child: RecentPatrolTable(),
                ),

                SizedBox(width:20),

                Expanded(
                  child: PatrolChart(),
                ),

              ],
            ),

            SizedBox(height:20),

            Row(
              children: [

                Expanded(
                  child: OfficerStatusCard(),
                ),

                SizedBox(width:20),

                // Expanded(
                //   child: LatestAlertsCard(),
                // ),

              ],
            ),

          ],
          )
          ),
        ),
      );
    
  }
}

class DashboardColors {
  static const Color background = Color(0xff081A3A);

  static const Color card = Color(0xff14264D);

  static const Color sidebar = Color(0xff0A1738);

  static const Color primary = Color(0xffFFC107);

  static const Color success = Color(0xff22C55E);

  static const Color danger = Color(0xffEF4444);

  static const Color warning = Color(0xffF59E0B);

  static const Color text = Colors.white;

  static const Color subText = Color(0xff98A2B3);

  static const Color border = Color(0xff233B68);
}