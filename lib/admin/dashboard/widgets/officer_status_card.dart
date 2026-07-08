import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/officer/model/officer_model.dart';
import '../controller/admin_dashboard_controller.dart';



class OfficerStatusCard extends GetView<DashboardController> {
  const OfficerStatusCard({super.key});

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
            final officers = controller.recentOfficerList;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------------------------------------------------
                // Header
                //------------------------------------------------------

                const Row(
                  children: [
                    Icon(
                      Icons.local_police,
                      color: Colors.indigo,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Officer Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //------------------------------------------------------
                // Empty
                //------------------------------------------------------

                if (officers.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text("No Officers Found"),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: officers.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1),
                    itemBuilder: (_, index) {
                      return _officerTile(
                        officers[index],
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  //----------------------------------------------------------
  // Officer Tile
  //----------------------------------------------------------

  Widget _officerTile(OfficerModel officer) {
    final bool online =
        officer.lastLogin != null &&
            DateTime.now()
                    .difference(
                      officer.lastLogin!.toDate(),
                    )
                    .inMinutes <
                10;

    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.indigo.shade100,
            child: const Icon(
              Icons.person,
              color: Colors.indigo,
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: online
                    ? Colors.green
                    : Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),

      title: Text(
        officer.fullName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            officer.badgeId,
          ),

          Text(
            officer.rank,
          ),

          Text(
            officer.stationName,
          ),
        ],
      ),

      trailing: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: online
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Text(
              online ? "ONLINE" : "OFFLINE",
              style: TextStyle(
                color: online
                    ? Colors.green.shade800
                    : Colors.red.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            officer.lastLogin == null
                ? "-"
                : officer.lastLogin!
                    .toDate()
                    .toString()
                    .substring(0, 16),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}