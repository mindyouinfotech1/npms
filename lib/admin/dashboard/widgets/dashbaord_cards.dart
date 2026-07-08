import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_dashboard_controller.dart';


class DashboardCards
    extends GetView<DashboardController> {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          _card(
            "Total Officers",
            controller.totalOfficers.value.toString(),
            Icons.local_police,
            Colors.blue,
          ),

          _card(
            "Today's Patrol",
            controller.todayPatrols.value.toString(),
            Icons.directions_walk,
            Colors.green,
          ),

          _card(
            "Total Patrols",
            controller.totalPatrols.value.toString(),
            Icons.history,
            Colors.orange,
          ),

          _card(
            "Stations",
            controller.totalStations.value.toString(),
            Icons.account_balance,
            Colors.indigo,
          ),

          _card(
            "Checkpoints",
            controller.totalCheckpoints.value.toString(),
            Icons.location_on,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _card(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return SizedBox(
      width: 250,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withOpacity(.12),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}