import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/patrol_controller.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/patrol_camera_card.dart';
import '../widgets/patrol_gps_card.dart';
import '../widgets/patrol_qr_scanner.dart';
import '../widgets/patrol_review_card.dart';


class HomePage extends GetView<PatrolController> {
   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xff081A3A),
      appBar: AppBar(
        backgroundColor: const Color(0xff081A3A),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Start Patrol",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _stepIndicator(),

                    const SizedBox(height: 25),

                    if (controller.currentStep.value == 1)
                      const PatrolQrScanner(),

                    if (controller.currentStep.value == 2)
                      const PatrolGpsCard(),

                    if (controller.currentStep.value == 3)
                      const PatrolCameraCard(),

                    if (controller.currentStep.value == 4)
                      const PatrolReviewCard(),
                  ],
                ),
              ),

              if (controller.loading.value)
                Container(
                  color: Colors.black38,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const OfficerBottomNavigationBar(),
    );
    
  }

Widget _stepIndicator() {
  return Obx(
    () => Row(
      children: List.generate(4, (index) {
        final step = index + 1;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: _stepTile(
                  step: step,
                  title: _titles[index],
                  icon: _icons[index],
                ),
              ),

              if (step != 4)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 22),
                    height: 2,
                    color: controller.currentStep.value > step
                        ? const Color(0xff53D769)
                        : Colors.white24,
                  ),
                ),
            ],
          ),
        );
      }),
    ),
  );
}

final List<String> _titles = [
  "QR",
  "GPS",
  "Camera",
  "Submit",
];

final List<IconData> _icons = [
  Icons.qr_code_scanner,
  Icons.location_on,
  Icons.camera_alt,
  Icons.check_circle,
];

Widget _stepTile({
  required int step,
  required String title,
  required IconData icon,
}) {
  final current = controller.currentStep.value;

  final completed = current > step;
  final active = current == step;

  return Column(
    children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: completed
              ? const Color(0xff53D769)
              : active
                  ? const Color(0xffFFC107)
                  : const Color(0xff233B68),
          border: Border.all(
            color: Colors.white10,
          ),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: const Color(0xffFFC107).withOpacity(.35),
                    blurRadius: 12,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: completed
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              )
            : Icon(
                icon,
                color: active ? Colors.black : Colors.white70,
                size: 20,
              ),
      ),

      const SizedBox(height: 8),

      Text(
        title,
        style: TextStyle(
          color: active
              ? const Color(0xffFFC107)
              : completed
                  ? const Color(0xff53D769)
                  : Colors.white54,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    ],
  );
}


}