import 'package:flutter/material.dart';

class QuantityCounter extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityCounter({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 140,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Row(
        children: [

          Expanded(
            child: IconButton(
              onPressed: onDecrement,
              icon: const Icon(
                Icons.remove_rounded,
              ),
            ),
          ),

          Container(
            width: 1,
            color: Colors.grey.shade200,
          ),

          Expanded(
            child: Center(
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            color: Colors.grey.shade200,
          ),

          Expanded(
            child: IconButton(
              onPressed: onIncrement,
              icon: const Icon(
                Icons.add_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}