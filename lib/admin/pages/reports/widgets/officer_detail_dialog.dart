import 'package:flutter/material.dart';
import '../model/officer_report_model.dart';

class OfficerDetailDialog extends StatelessWidget {
  final OfficerReportModel officer;

  const OfficerDetailDialog({
    super.key,
    required this.officer,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(officer.officerName),
      content: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("Badge ID"),
              subtitle: Text(officer.badgeId),
            ),

            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text("Rank"),
              subtitle: Text(officer.rank),
            ),

            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text("Police Station"),
              subtitle: Text(officer.stationName),
            ),

            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text("Assigned QR"),
              subtitle: Text(
                officer.assignedQrPoints.toString(),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text("Visited"),
              subtitle: Text(
                officer.visitedQrPoints.toString(),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text("Missed"),
              subtitle: Text(
                officer.missedQrPoints.toString(),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text("Compliance"),
              subtitle: Text(
                officer.complianceText,
              ),
            ),

            if (officer.lastPatrolTime != null)
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text("Last Patrol"),
                subtitle: Text(
                  officer.lastPatrolTime.toString(),
                ),
              ),
          ],
        ),
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