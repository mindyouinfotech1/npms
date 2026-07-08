import 'package:get/get.dart';

import '../../../mobile/auth/controller/auth_controller.dart';
import '../../../mobile/auth/service/auth_service.dart';

class OfficerAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficerLoginService>(
      () => OfficerLoginService(),
      fenix: true,
    );

    Get.lazyPut<OfficerLoginController>(
      () => OfficerLoginController(),
      fenix: true,
    );
  }
}