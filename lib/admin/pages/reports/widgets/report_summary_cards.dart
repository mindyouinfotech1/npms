import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/report_controller.dart';

class ReportSummaryCards extends GetView<ReportController> {
  const ReportSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
     debugPrint(
      "Summary Controller Hash : ${controller.hashCode}");
  
   return LayoutBuilder(

          builder: (context, constraints) {
            int crossAxisCount = 5;
      
            if (constraints.maxWidth < 1200) {
              crossAxisCount = 3;
            }
      
            if (constraints.maxWidth < 700) {
              crossAxisCount = 2;
            }
      
            if (constraints.maxWidth < 450) {
              crossAxisCount = 1;
            }
      
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 1.9,
              children: [
      
                _card(
                  title: "Stations",
                  value: controller.totalStations.value.toString(),
                  icon: Icons.account_balance,
                  color: Colors.indigo,
                ),
      
                _card(
                  title: "QR Points",
                  value: controller.totalQrPoints.value.toString(),
                  icon: Icons.qr_code,
                  color: Colors.orange,
                ),
      
                _card(
                  title: "Visited",
                  value: controller.totalVisited.value.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
      
                _card(
                  title: "Missed",
                  value: controller.totalMissed.value.toString(),
                  icon: Icons.cancel,
                  color: Colors.red,
                ),
      
                _card(
                  title: "Compliance",
                  value:
                      "${controller.compliance.value.toStringAsFixed(1)}%",
                  icon: Icons.analytics,
                  color: Colors.cyan,
                ),
              ],
            );
          },
        );
  
  }
    
    


  //----------------------------------------------------------

  Widget _card({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff14264D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white10,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.18),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [

          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}