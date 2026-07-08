import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:npms/admin/splash/admin_splash.dart';
import 'package:npms/core/services/session_manager.dart';
import 'package:npms/firebase_options.dart';
import 'package:npms/mobile/splashScreen/splash_screen.dart';


import 'core/bindings/initial_bindings.dart';
import 'core/constants/app_theme.dart';
import 'core/controllers/global_loader_controller.dart';
import 'core/routes/appRoutes.dart';
import 'mobile/auth/session_manager.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await SessionManager.init();
 await OfficerSession.init();

  runApp(const NPMS());
}

class NPMS extends StatelessWidget {
  const NPMS({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NPMS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      initialBinding: InitialBinding(),

      initialRoute: kIsWeb
          ? AppRoutes.adminSplash
          : AppRoutes.splash,
     

      getPages: AppRoutes.pages,

      builder: (context, child) {
        final loader = Get.find<GlobalLoaderController>();

        return Obx(() {
          return Stack(
            children: [
              child ?? const SizedBox(),

              if (loader.isLoading.value)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ),
            ],
          );
        });
      },
    );
  }
}