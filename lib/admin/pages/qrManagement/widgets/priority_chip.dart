import 'package:flutter/material.dart';

class PriorityChip extends StatelessWidget {
  final String priority;

  const PriorityChip({
    super.key,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (priority.toLowerCase()) {
      case "critical":
        backgroundColor = const Color(0xffFDECEC);
        textColor = Colors.red.shade700;
        icon = Icons.warning_amber_rounded;
        break;

      case "high":
        backgroundColor = const Color(0xffFFF4E5);
        textColor = Colors.deepOrange;
        icon = Icons.priority_high;
        break;

      case "medium":
        backgroundColor = const Color(0xffFFF9E6);
        textColor = Colors.orange.shade700;
        icon = Icons.flag;
        break;

      default:
        backgroundColor = const Color(0xffEAF7EE);
        textColor = Colors.green.shade700;
        icon = Icons.check_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: textColor,
          ),

          const SizedBox(width: 6),

          Text(
            priority,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}