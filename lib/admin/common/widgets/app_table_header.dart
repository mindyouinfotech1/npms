import 'package:flutter/material.dart';

class AppTableHeader extends StatelessWidget {
  final String title;
  final Widget? search;
  final List<Widget>? actions;

  const AppTableHeader({
    super.key,
    required this.title,
    this.search,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          if (search != null)
            SizedBox(
              width: 320,
              child: search!,
            ),

          if (actions != null) ...[
            const SizedBox(width: 10),
            ...actions!,
          ],
        ],
      ),
    );
  }
}