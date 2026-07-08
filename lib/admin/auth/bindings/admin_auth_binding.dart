import 'package:get/get.dart';

import '../controller/admin_auth_controller.dart';

class AdminAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminAuthController());
  }
}