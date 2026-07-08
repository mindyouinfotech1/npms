import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_dashboard_controller.dart';

class PatrolChart extends GetView<DashboardController> {
  const PatrolChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () {
            if (controller.loading.value) {
              return const SizedBox(
                height: 320,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.bar_chart,
                      color: Colors.indigo,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Last 7 Days Patrol Activity",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 320,
                  child: _buildChart(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChart() {
    if (controller.weeklyPatrols.isEmpty) {
      return const Center(
        child: Text(
          "No patrol data available.",
        ),
      );
    }

    // Replace this placeholder with your preferred chart package
    // (fl_chart, syncfusion_flutter_charts, etc.)
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.weeklyPatrols.length,
      itemBuilder: (_, index) {
        final item = controller.weeklyPatrols[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  item.day,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final max = controller.maxWeeklyPatrol == 0
                        ? 1
                        : controller.maxWeeklyPatrol;

                    final width =
                        (item.count / max) * constraints.maxWidth;

                    return Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 15),

              SizedBox(
                width: 40,
                child: Text(
                  item.count.toString(),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}