import 'package:flutter/material.dart';

class AppTableFooter extends StatelessWidget {
  final int totalRecords;
  final Widget? pagination;
  final List<Widget>? actions;

  const AppTableFooter({
    super.key,
    required this.totalRecords,
    this.pagination,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(0, 255, 255, 255),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            "Total Records : $totalRecords",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const Spacer(),

          if (pagination != null) pagination!,

          if (actions != null) ...[
            const SizedBox(width: 15),
            ...actions!,
          ],
        ],
      ),
    );
  }
}