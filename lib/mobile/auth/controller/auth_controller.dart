import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/appRoutes.dart';
import '../../../admin/pages/officer/model/officer_model.dart';
import '../../../mobile/auth/service/auth_service.dart';
import '../../../mobile/auth/session_manager.dart';

class OfficerLoginController extends GetxController {
  final OfficerLoginService service = OfficerLoginService();

  //----------------------------------------------------------
  // Controllers
  //----------------------------------------------------------

  final badgeIdController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  //----------------------------------------------------------
  // State
  //----------------------------------------------------------

  final loading = false.obs;

  final hidePassword = true.obs;

  //----------------------------------------------------------
  // Password Visibility
  //----------------------------------------------------------

  void togglePassword() {
    hidePassword.toggle();
  }

  //----------------------------------------------------------
  // Login
  //----------------------------------------------------------

Future<void> login() async {
  if (!formKey.currentState!.validate()) {
    return;
  }

  loading(true);

  try {
    debugPrint("Starting Officer Login...");

    final OfficerModel? officer = await service.login(
      badgeId: badgeIdController.text.trim(),
      password: passwordController.text.trim(),
    );

    debugPrint("Officer : $officer");

    if (officer == null) {
      Get.snackbar(
        "Login Failed",
        "Invalid Badge ID or Password.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    debugPrint("Saving Session...");

    await OfficerSession.setLogin(
      uid: officer.id,
      name: officer.fullName,
      email: officer.email,
      mobile: officer.mobile,
      loginType: "officer",
      badgeId: officer.badgeId,
      rank: officer.rank,
      stationId: officer.stationId,
      stationName: officer.stationName,
      shift: officer.shift,
    );

    debugPrint("Session Saved");

    debugPrint("Updating Last Login...");

    await service.updateLastLogin(officer.id);

    debugPrint("Last Login Updated");

    Get.snackbar(
      "Success",
      "Login Successful",
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.offAllNamed(AppRoutes.home);
  } catch (e, stack) {
    debugPrint("=========== LOGIN ERROR ===========");
    debugPrint("Error: $e");
    debugPrint("StackTrace:");
    debugPrint(stack.toString());
    debugPrint("===================================");

    Get.snackbar(
      "Error",
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  } finally {
    loading(false);
  }
}

  // Clear
  //----------------------------------------------------------

  void clear() {
    badgeIdController.clear();
    passwordController.clear();
  }

  //----------------------------------------------------------
  // Dispose
  //----------------------------------------------------------

  @override
  void onClose() {
    badgeIdController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}