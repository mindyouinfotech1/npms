import 'package:flutter/material.dart';

class CustomHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Colors.white,

      title: Row(
        children: [

          Image.asset(
            "assets/logo.jpeg",
            height: 40,
          ),

          const Spacer(),

          const Icon(Icons.location_on_outlined),

          const SizedBox(width: 4),

          const Text(
            "Lucknow",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),

          const SizedBox(width: 12),

          Stack(
            children: [

              const Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),

              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "3",
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}