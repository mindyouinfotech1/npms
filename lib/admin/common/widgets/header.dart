import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/session_manager.dart';
import '../controller/admin_side_bar_controller.dart';


class AdminHeader extends GetView<AdminLayoutController> {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xff08152F),
        border: Border(
          bottom: BorderSide(
            color: Colors.white10,
          ),
        ),
      ),
      child: Row(
        children: [
          /// Menu Button
          IconButton(
            onPressed: controller.toggleSidebar,
            icon: const Icon(
              Icons.menu,
              color: Colors.white70,
            ),
          ),

          const SizedBox(width: 10),

          /// Title
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kaimur District Police",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Night Patrol Monitoring System",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const Spacer(),

          /// Live Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(.15),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.green.withOpacity(.30),
              ),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  "LIVE",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          /// Notification
          Stack(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xff16284F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white70,
                ),
              ),

              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "2",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 18),

          /// User Profile
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff16284F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xffFFC107),
                  child: Text(
                    SessionManager.name.isNotEmpty
                        ? SessionManager.name[0].toUpperCase()
                        : "A",
                    style: const TextStyle(
                      color: Color(0xff08152F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SessionManager.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 2),

                    const Text(
                      "Administrator",
                      style: TextStyle(
                        color: Color(0xffFFC107),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 8),

                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white60,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}