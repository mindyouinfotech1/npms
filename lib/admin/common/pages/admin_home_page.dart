import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_side_bar_controller.dart';
import '../widgets/body_container.dart';
import '../widgets/header.dart';
import '../widgets/sidebar.dart';

class AdminHomePage extends GetView<AdminLayoutController> {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081A3A),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Sidebar
            const AdminSidebar(),

            /// Vertical Divider
            Container(
              width: 1,
              color: Colors.white12,
            ),

            /// Main Content
            Expanded(
              child: Container(
                color: const Color(0xFF10264E),
                child: Column(
                  children: [
                    /// Header
                    const AdminHeader(),

                    /// Body
                    Expanded(
                      child: ClipRect(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: const BodyContainer(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}