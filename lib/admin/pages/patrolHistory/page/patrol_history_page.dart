import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/patrol_history_controller.dart';
import '../widgets/patrol_history_table.dart';

class PatrolHistoryPage extends GetView<PatrolHistoryController> {
  const PatrolHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //------------------------------------------------------
          // HEADER
          //------------------------------------------------------

          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Patrol History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "View and monitor completed patrols",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: controller.loadPatrols,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFC107),
                      foregroundColor: const Color(0xff081A3A),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Patrol History",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "View and monitor completed patrols",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 170,
                    maxWidth: 220,
                    minHeight: 45,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: controller.loadPatrols,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xffFFC107),
                      foregroundColor:
                          const Color(0xff081A3A),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 25),

          //------------------------------------------------------
          // TABLE
          //------------------------------------------------------

          Expanded(
            child: Obx(() {
              if (controller.loading.value &&
                  controller.patrolList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const PatrolHistoryTable();
            }),
          ),
        ],
      ),
    );
  }
}