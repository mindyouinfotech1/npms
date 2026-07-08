import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/police_station_controller.dart';
import '../widget/police_station_grid.dart';
import 'police_station_dialog.dart';

class PoliceStationPage extends GetView<PoliceStationController> {
  const PoliceStationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ==========================
              /// Header
              /// ==========================
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Police Station Management",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Manage Police Stations & Patrol Areas",
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
                            icon: const Icon(Icons.add),
                            label: const Text("Add Station"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xffFFC107),
                              foregroundColor:
                                  const Color(0xff081A3A),
                            ),
                            onPressed: () {
                              controller.clearForm();

                              Get.dialog(
                                const PoliceStationDialog(),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Police Station Management",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Manage Police Stations & Patrol Areas",
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
                            minHeight: 48,
                          ),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text("Add Station"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xffFFC107),
                              foregroundColor:
                                  const Color(0xff081A3A),
                            ),
                            onPressed: () {
                              controller.clearForm();

                              Get.dialog(
                                const PoliceStationDialog(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

              SizedBox(height: isMobile ? 16 : 25),

              /// ==========================
              /// Search
              /// ==========================
              isMobile
                  ? Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Search Station...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) {
                            controller.search.value = value;
                          },
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            IconButton(
                              onPressed:
                                  controller.loadStations,
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),

                            const Spacer(),

                            Obx(
                              () => Text(
                                "${controller.stationList.length} Stations",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: 350,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search Station...",
                              prefixIcon:
                                  const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                            onChanged: (value) {
                              controller.search.value = value;
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        IconButton(
                          onPressed:
                              controller.loadStations,
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),

                        const Spacer(),

                        Obx(
                          () => Text(
                            "${controller.stationList.length} Stations",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

              SizedBox(height: isMobile ? 16 : 25),

              /// ==========================
              /// Grid
              /// ==========================
              const Expanded(
                child: PoliceStationGrid(),
              ),
            ],
          ),
        );
      },
    );
  }
}