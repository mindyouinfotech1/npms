import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../mobile/home/model/patrol_model.dart';
class PatrolHistoryDialog extends StatelessWidget {
  final PatrolHistoryModel patrol;

  const PatrolHistoryDialog({
    super.key,
    required this.patrol,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      child: SizedBox(
        width: 700,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //------------------------------------------------------
              // Title
              //------------------------------------------------------

              Row(
                children: [
                  const Icon(
                    Icons.local_police,
                    color: Colors.indigo,
                    size: 30,
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Text(
                      "Patrol Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const Divider(height: 30),

              //------------------------------------------------------
              // Officer
              //------------------------------------------------------

              const Text(
                "Officer Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _row("Officer", patrol.officerName),
              _row("Badge ID", patrol.badgeId),
              _row("Rank", patrol.rank),
              _row("Station", patrol.stationName),

              const SizedBox(height: 25),

              //------------------------------------------------------
              // Checkpoint
              //------------------------------------------------------

              const Text(
                "Checkpoint Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _row("Checkpoint", patrol.checkpointName),
              _row("Checkpoint ID", patrol.checkpointId),

              _row(
                "Latitude",
                patrol.checkpointLatitude.toStringAsFixed(6),
              ),

              _row(
                "Longitude",
                patrol.checkpointLongitude.toStringAsFixed(6),
              ),

              const SizedBox(height: 25),

              //------------------------------------------------------
              // GPS
              //------------------------------------------------------

              const Text(
                "Officer GPS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _row(
                "Latitude",
                patrol.officerLatitude.toStringAsFixed(6),
              ),

              _row(
                "Longitude",
                patrol.officerLongitude.toStringAsFixed(6),
              ),

              _row(
                "GPS Accuracy",
                "${patrol.gpsAccuracy.toStringAsFixed(2)} m",
              ),

              _row(
                "Distance",
                "${patrol.distance.toStringAsFixed(2)} m",
              ),

              const SizedBox(height: 25),

              //------------------------------------------------------
              // Patrol Time
              //------------------------------------------------------

              const Text(
                "Patrol Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _row(
                "Patrol Time",
                patrol.patrolTime == null
                    ? "-"
                    : DateFormat(
                        "dd MMM yyyy hh:mm a",
                      ).format(
                        patrol.patrolTime!.toDate(),
                      ),
              ),

              _row(
                "Status",
                patrol.status.toUpperCase(),
              ),

              const SizedBox(height: 25),

              //------------------------------------------------------
              // Remarks
              //------------------------------------------------------

              const Text(
                "Remarks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  patrol.remarks.isEmpty
                      ? "No Remarks"
                      : patrol.remarks,
                ),
              ),

              const SizedBox(height: 25),

              //------------------------------------------------------
              // Photo
              //------------------------------------------------------

              const Text(
                "Patrol Photo",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: patrol.photoUrl.isEmpty
                    ? Container(
                        height: 250,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Text("No Image"),
                        ),
                      )
                    : Image.network(
                        patrol.photoUrl,
                        width: double.infinity,
                        height: 350,
                        fit: BoxFit.cover,
                      ),
              ),

              const SizedBox(height: 25),

              //------------------------------------------------------
              // Close
              //------------------------------------------------------

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  label: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}