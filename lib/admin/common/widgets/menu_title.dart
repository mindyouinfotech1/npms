import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/admin_side_bar_controller.dart';

class MenuTile extends GetView<AdminLayoutController> {
  final String title;
  final IconData icon;
  final AdminMenu menu;
  final int? badge;

  const MenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.menu,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      final selected =
          controller.selectedMenu.value == menu;

      return InkWell(
        onTap: () {
          controller.changeMenu(menu);
        },
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withOpacity(.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: selected
                ? const Border(
                    left: BorderSide(
                      color: Color(0xffFFC107),
                      width: 4,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [

              Icon(
                icon,
                color: selected
                    ? const Color(0xffFFC107)
                    : Colors.white60,
                size: 21,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Colors.white60,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),

              if (badge != null)
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badge.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}