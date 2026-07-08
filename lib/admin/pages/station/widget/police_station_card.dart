import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/police_station_controller.dart';
import '../model/police_station_model.dart';


class PoliceStationCard extends GetView<PoliceStationController> {
  final PoliceStationModel station;

  const PoliceStationCard({
    super.key,
    required this.station,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header
            Row(
              children: [

                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.indigo.shade50,
                  child: Icon(
                    Icons.local_police,
                    color: Colors.indigo.shade700,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        station.stationName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        "${station.district} • ${station.type}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: station.status == "active"
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    station.status.toUpperCase(),
                    style: TextStyle(
                      color: station.status == "active"
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Divider(),

            /// Statistics
            _statTile(
              Icons.people,
              "Officers",
              "5",
            ),

            // _statTile(
            //   Icons.directions_walk,
            //   "On Patrol",
            //   "80",
            // ),

            _statTile(
              Icons.qr_code,
              "Checkpoints",
              "50"
              // station.totalCheckpoints.toString(),
            ),

            _statTile(
              Icons.how_to_reg,
              "Attendance",
              "50"
            ),

            const Spacer(),

            const Divider(),

            /// Actions
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [

                IconButton(
                  tooltip: "View",
                  onPressed: () =>
                      controller.viewStation(station),
                  icon: const Icon(
                    Icons.visibility,
                    color: Colors.indigo,
                  ),
                ),

                IconButton(
                  tooltip: "Edit",
                  onPressed: () =>
                      controller.editStation(station),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.orange,
                  ),
                ),

                // IconButton(
                //   tooltip: "View QR",
                //   onPressed: () =>
                //       controller.viewStationQr(station),
                //   icon: const Icon(
                //     Icons.qr_code,
                //     color: Colors.green,
                //   ),
                // ),

                IconButton(
                  tooltip: "Delete",
                  onPressed: () =>
                      controller.deleteStation(station),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [

          Icon(
            icon,
            size: 20,
            color: Colors.indigo,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(title),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}