
import 'package:get/get.dart';
import 'package:npms/admin/pages/officer/controller/officer_controller.dart';
import 'package:npms/admin/pages/officer/service/officer_service.dart';
import 'package:npms/admin/pages/patrolHistory/controller/patrol_history_controller.dart';
import 'package:npms/admin/pages/reports/controller/report_controller.dart';
import 'package:npms/admin/pages/station/services/police_station_service.dart';
import '../../mobile/auth/bindings/auth_bindings.dart';
import '../../mobile/home/controller/patrol_controller.dart';
import '../controllers/global_loader_controller.dart';
import '../services/admin_auth_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalLoaderController(), permanent: true);
    Get.put(AdminAuthService(), permanent: true);
    Get.put(PoliceStationService(), permanent: true);
    Get.put(OfficerService(), permanent: true);
    Get.put(OfficerController(), permanent: true);
    Get.put(OfficerAuthBinding(), permanent: true);
    Get.put(PatrolController(), permanent: true);
    Get.put(PatrolHistoryController(), permanent: true);
    Get.put(ReportController(), permanent: true);
    
    
    

     
  }
}
