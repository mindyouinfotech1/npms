import 'package:get/get.dart';

import '../controller/forgot_password_controller.dart' show ForgotPasswordController;

class ForgotPasswordBinding extends Bindings {
  @override
 void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}