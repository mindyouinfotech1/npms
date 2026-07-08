import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../mobile/home/model/patrol_model.dart';
import '../../../common/widgets/app_data_table_row.dart';
import '../../../common/widgets/app_table_actions.dart';

import '../controller/patrol_history_controller.dart';
import 'patrol_history_dialog.dart';


class PatrolHistoryRow {
  static DataRow build({
    required int index,
    required PatrolHistoryModel patrol,
    required PatrolHistoryController controller,
  }) {
    return AppDataTableRow.build(
      index: index,
      cells: [
        Text(patrol.officerName),

        Text(patrol.badgeId),

        Text(patrol.stationName),

        Text(patrol.checkpointName),

        Text(
          "${patrol.distance.toStringAsFixed(2)} m",
        ),

        Text(
          "${patrol.gpsAccuracy.toStringAsFixed(1)} m",
        ),

        Text(
          patrol.patrolTime == null
              ? "-"
              : "${patrol.patrolTime!.toDate().day}/"
                  "${patrol.patrolTime!.toDate().month}/"
                  "${patrol.patrolTime!.toDate().year}",
        ),

        _statusChip(patrol.status),

        patrol.photoUrl.isEmpty
            ? const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  patrol.photoUrl,
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                ),
              ),

        AppTableActions(
          onView: () {
            Get.dialog(
              PatrolHistoryDialog(
                patrol: patrol,
              ),
            );
          },
          onDelete: () {
            controller.deletePatrol(patrol);
          },
        ),
      ],
    );
  }

  static Widget _statusChip(String status) {
    final completed = status.toLowerCase() == "completed";

    return Chip(
      backgroundColor: completed
          ? Colors.green.shade100
          : Colors.orange.shade100,
      label: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: completed
              ? Colors.green.shade800
              : Colors.orange.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}