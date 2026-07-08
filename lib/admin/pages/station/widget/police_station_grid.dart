import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/police_station_controller.dart';
import 'police_station_card.dart';

class PoliceStationGrid extends GetView<PoliceStationController> {
  const PoliceStationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final keyword = controller.search.value.toLowerCase();

      final stations = controller.stationList.where((station) {
        return station.stationName
                .toLowerCase()
                .contains(keyword) ||
            station.district
                .toLowerCase()
                .contains(keyword) ||
            station.type
                .toLowerCase()
                .contains(keyword);
      }).toList();

      if (controller.loading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (stations.isEmpty) {
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_police_outlined,
                size: 70,
                color: Colors.white54,
              ),
              SizedBox(height: 15),
              Text(
                "No Police Stations Found",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;

          if (constraints.maxWidth > 1600) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 1200) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 2;
          }

          return GridView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: stations.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (_, index) {
              return PoliceStationCard(
                station: stations[index],
              );
            },
          );
        },
      );
    });
  }
}