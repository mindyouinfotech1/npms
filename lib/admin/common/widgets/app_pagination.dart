import 'package:flutter/material.dart';

class AppPagination extends StatelessWidget {
  final int page;

  final bool hasPrevious;
  final bool hasNext;

  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const AppPagination({
    super.key,
    required this.page,
    required this.hasPrevious,
    required this.hasNext,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: hasPrevious ? onPrevious : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
          ),
          child: const Text(
            "Previous",
            style: TextStyle(color: Colors.white),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Page $page",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        OutlinedButton(
          onPressed: hasNext ? onNext : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
          ),
          child: const Text(
            "Next",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}