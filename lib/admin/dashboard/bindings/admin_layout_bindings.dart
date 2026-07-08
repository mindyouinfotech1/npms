import 'package:get/get.dart';
import 'package:npms/admin/pages/station/controller/police_station_controller.dart';

import '../../common/controller/admin_side_bar_controller.dart';
import '../controller/admin_dashboard_controller.dart';
import '../../pages/qrManagement/controller/qr_management_controller.dart';
import '../../pages/qrManagement/services/qr_management_service.dart' show QrManagementService;

class AdminLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminLayoutController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => QrManagementService());

    Get.lazyPut(() => QrManagementController());
    Get.lazyPut(() => PoliceStationController());
  }
}