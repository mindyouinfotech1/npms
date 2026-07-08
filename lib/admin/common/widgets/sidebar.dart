import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:npms/core/services/session_manager.dart';

import '../../../core/routes/appRoutes.dart';
import '../controller/admin_side_bar_controller.dart';
import 'menu_title.dart';



class AdminSidebar extends GetView<AdminLayoutController> {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      color: const Color(0xff0B1B46),
      child: Column(
        children: [

          /// Logo
          Container(
            height: 82,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white10,
                ),
              ),
            ),
            child: Row(
              children: [

                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFC107),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/logo.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "NPMS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      "KAIMUR POLICE",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Expanded(
            child: SingleChildScrollView(
              child:Column(
                  children: [

                    MenuTile(
                      title: "Dashboard",
                      icon: Icons.dashboard_outlined,
                      menu: AdminMenu.dashboard,
                    ),


                    MenuTile(
                    title: "QR Management",
                    icon: Icons.qr_code,
                    menu: AdminMenu.qrManagement,
                  ),

                    MenuTile(
                      title: "Police Stations",
                      icon: Icons.home_work_outlined,
                      menu: AdminMenu.policeStation,
                    ),

                    MenuTile(
                      title: "Officers",
                      icon: Icons.people_outline,
                      menu: AdminMenu.officers,
                    ),

                    MenuTile(
                      title: "Patrol History",
                      icon: Icons.history,
                      menu: AdminMenu.patrolHistory,
                    ),

                    MenuTile(
                      title: "Reports",
                      icon: Icons.description_outlined,
                      menu: AdminMenu.reports,
                    ),

                    // MenuTile(
                    //   title: "Analytics",
                    //   icon: Icons.bar_chart,
                    //   menu: AdminMenu.analytics,
                    // ),

                    // MenuTile(
                    //   title: "Notifications",
                    //   icon: Icons.notifications_none,
                    //   menu: AdminMenu.notifications,
                    //   badge: 2,
                    // ),

                    MenuTile(
                      title: "Settings",
                      icon: Icons.settings_outlined,
                      menu: AdminMenu.settings,
                    ),
                  ],
                ),
              ),
            ),
          

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: ()async {
                  await SessionManager.logout();

                    // Remove all previous routes and go to login
                    Get.offAllNamed(AppRoutes.adminLoginPage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(.12),
                  foregroundColor: Colors.redAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.logout),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}