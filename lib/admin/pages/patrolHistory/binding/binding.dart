import 'package:get/get.dart';

import '../controller/patrol_history_controller.dart';

class PatrolHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatrolHistoryController>(
      () => PatrolHistoryController(),
      fenix: true,
    );
  }
}