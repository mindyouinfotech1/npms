import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/station_report_model.dart';

class StationReportCard extends StatelessWidget {
  final StationReportModel report;

  final VoidCallback? onView;

  const StationReportCard({
    super.key,
    required this.report,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final compliance = report.compliance;

    Color statusColor;

    String status;

    if (compliance >= 90) {
      statusColor = Colors.green;
      status = "Excellent";
    } else if (compliance >= 75) {
      statusColor = Colors.orange;
      status = "Good";
    } else {
      statusColor = Colors.red;
      status = "Needs Attention";
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff14264D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white10,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          //--------------------------------------------------
          // Station
          //--------------------------------------------------

          Row(
            children: [

              CircleAvatar(
                radius: 22,
                backgroundColor:
                    Colors.indigo.withOpacity(.18),
                child: const Icon(
                  Icons.account_balance,
                  color: Colors.amber,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  report.stationName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          //--------------------------------------------------
          // Statistics
          //--------------------------------------------------

          _tile(
            Icons.qr_code,
            "Total QR",
            report.totalQrPoints.toString(),
          ),

          _tile(
            Icons.check_circle,
            "Visited",
            report.visitedQrPoints.toString(),
            color: Colors.green,
          ),

          _tile(
            Icons.cancel,
            "Missed",
            report.missedQrPoints.toString(),
            color: Colors.red,
          ),

          _tile(
            Icons.people,
            "Officers",
            report.totalOfficers.toString(),
          ),

          const SizedBox(height: 18),

          //--------------------------------------------------
          // Compliance
          //--------------------------------------------------

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "Compliance",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              Text(
                "${compliance.toStringAsFixed(1)}%",
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: compliance / 100,
              minHeight: 12,
              color: statusColor,
              backgroundColor:
                  Colors.white10,
            ),
          ),

          const SizedBox(height: 15),

          //--------------------------------------------------
          // Status
          //--------------------------------------------------

          Align(
            alignment: Alignment.centerLeft,
            child: Chip(
              backgroundColor:
                  statusColor.withOpacity(.15),
              side: BorderSide.none,
              avatar: Icon(
                Icons.verified,
                size: 18,
                color: statusColor,
              ),
              label: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          //--------------------------------------------------
          // Button
          //--------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xffFFC107),
                foregroundColor:
                    const Color(0xff081A3A),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
              onPressed: onView,
              icon: const Icon(
                Icons.visibility,
              ),
              label: const Text(
                "View Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------
  // Tile
  //----------------------------------------------------------

  Widget _tile(
    IconData icon,
    String title,
    String value, {
    Color color = Colors.white,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [

          Icon(
            icon,
            size: 18,
            color: color,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}