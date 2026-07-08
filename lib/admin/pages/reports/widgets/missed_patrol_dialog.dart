import 'package:flutter/material.dart';
import '../model/missed_patrol_model.dart';

class MissedPatrolDialog extends StatelessWidget {
  final MissedPatrolModel checkpoint;

  const MissedPatrolDialog({
    super.key,
    required this.checkpoint,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Missed Patrol"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Station: ${checkpoint.stationName}"),
          Text("Checkpoint: ${checkpoint.checkpointName}"),
          Text("QR ID: ${checkpoint.qrId}"),
          Text("Priority: ${checkpoint.priority}"),
          Text(
            "Officer: ${checkpoint.officerName.isEmpty ? "Not Assigned" : checkpoint.officerName}",
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }
}