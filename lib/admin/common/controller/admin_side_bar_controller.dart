import 'package:get/get.dart';

import '../../../core/routes/appRoutes.dart';
import '../../../core/services/session_manager.dart';

enum AdminMenu {
  dashboard,
  policeStation,
  officers,
  patrolHistory,
  qrManagement,
  reports,
  // analytics,
  // notifications,
  settings,
}

class AdminLayoutController extends GetxController {
  /// Sidebar
  final isSidebarCollapsed = false.obs;

  /// Current Selected Menu
  final selectedMenu = AdminMenu.dashboard.obs;

  /// Page Title
  final pageTitle = "Dashboard".obs;

  /// Breadcrumb
  final breadCrumb = "Home / Dashboard".obs;

  /// Toggle Sidebar
  void toggleSidebar() {
    isSidebarCollapsed.toggle();
  }

  /// Change Page
  void changeMenu(AdminMenu menu) {
    selectedMenu.value = menu;

    switch (menu) {
      case AdminMenu.dashboard:
        pageTitle.value = "Dashboard";
        breadCrumb.value = "Home / Dashboard";
        break;

      case AdminMenu.policeStation:
        pageTitle.value = "Police Stations";
        breadCrumb.value = "Home / Police Stations";
        break;

      case AdminMenu.officers:
        pageTitle.value = "Police Officers";
        breadCrumb.value = "Home / Police Officers";
        break;

  

      case AdminMenu.qrManagement:
        pageTitle.value = "QR Locations";
        breadCrumb.value = "Home / QR Locations";
        break;


      case AdminMenu.reports:
        pageTitle.value = "Reports";
        breadCrumb.value = "Home / Reports";
        break;

      case AdminMenu.settings:
        pageTitle.value = "Settings";
        breadCrumb.value = "Home / Settings";
        break;
      case AdminMenu.patrolHistory:
       
        throw UnimplementedError();
    
     
      // case AdminMenu.analytics:
      //   // TODO: Handle this case.
      //   throw UnimplementedError();

      // case AdminMenu.notifications:
      //   // TODO: Handle this case.
      //   throw UnimplementedError();

    }
  }

  /// Logout
  Future<void> logout() async {
    await SessionManager.logout();

    Get.offAllNamed(AppRoutes.adminLoginPage);
  }
}