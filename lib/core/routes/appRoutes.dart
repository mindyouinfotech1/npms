
import 'package:get/get.dart';
import 'package:npms/Mobile/profile/profile.dart';
import 'package:npms/admin/common/pages/admin_home_page.dart';
import 'package:npms/admin/pages/patrolHistory/binding/binding.dart';
import 'package:npms/admin/pages/patrolHistory/page/patrol_history_page.dart';
import 'package:npms/admin/pages/reports/page/report_page.dart';
import 'package:npms/admin/splash/admin_splash.dart';
import '../../admin/auth/bindings/admin_auth_binding.dart';
import '../../admin/auth/bindings/forgot_password_binding.dart';
import '../../admin/auth/bindings/otp_verification_binding.dart';
import '../../admin/auth/bindings/reset_password_binding.dart';
import '../../admin/auth/forgot_password.dart';
import '../../admin/auth/login.dart';
import '../../admin/auth/otp_verification.dart';
import '../../admin/auth/reset_password_page.dart';
import '../../admin/dashboard/bindings/admin_layout_bindings.dart';
import '../../admin/pages/officer/binding/officer_binding.dart';
import '../../admin/pages/reports/binding/report_binding.dart';
import '../../mobile/auth/view/login_page.dart';
import '../../mobile/auth/view/otp_page.dart';
import '../../mobile/auth/view/register.dart';
import '../../mobile/home/pages/home_page.dart';
import '../../mobile/splashScreen/splash_screen.dart';
import '../middleware/auth_middleware.dart';


class AppRoutes {
  static const splash = '/';
  static const adminSplash = '/adminSplash';
  static const home = '/home';
  static const login = '/login';
  static const profile = '/profile';





  ///Admin Routes
  static const adminLoginPage = '/adminLogin'; 
  static const resetPassword = '/resetPassword';
  static const otpVerification = '/otpVerification';
  static const forgotPasswordPage = '/forgotPassword';
  static const adminHomePage = '/adminHomePage';
  static const patrolHistory = '/patrolHistory';
  static const reports = '/reports';



static final pages = [

  GetPage(
    name: splash,
    page: () => const SplashScreen(),
  ),

  GetPage(
    name: profile,
    page: () => const ProfilePage(),
  ),

   GetPage(
    name: adminSplash,
    page: () => const AdminSplash(),
  ),

  GetPage(
    name: login,
    page: () => OfficerLoginPage(),
      binding: OfficerAuthBinding(),
  ),

 


  /// Public Pages
  GetPage(
    name: home,
    page: () =>  HomePage(),
  ),




  ///Admin Routes
  GetPage(
    name: AppRoutes.adminLoginPage,
    page: () => const AdminLoginPage(),
    binding: AdminAuthBinding(),
  ),

    GetPage(
  name: AppRoutes.forgotPasswordPage,
  page: () => const ForgotPasswordPage(),
  binding: ForgotPasswordBinding(),
),

GetPage(
  name: AppRoutes.otpVerification,
  page: () => const OtpVerificationPage(),
  binding: OtpVerificationBinding(),
),

GetPage(
  name: AppRoutes.resetPassword,
  page: () => const ResetPasswordPage(),
  binding: ResetPasswordBinding(),
),

GetPage(
  name: AppRoutes.adminHomePage,
  page: () => const AdminHomePage(),
  binding: AdminLayoutBinding(),
),


GetPage(
  name: AppRoutes.patrolHistory,
  page: () => const PatrolHistoryPage(),
  binding: PatrolHistoryBinding(),
),


GetPage(
  name: AppRoutes.reports,
  page: () => const ReportPage(),
  binding: ReportBinding(),
),


];



}
