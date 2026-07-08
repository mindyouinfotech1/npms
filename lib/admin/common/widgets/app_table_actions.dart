import 'package:flutter/material.dart';

class AppTableActions extends StatelessWidget {
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AppTableActions({
    super.key,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onView != null)
          IconButton(
            tooltip: "View",
            icon: const Icon(
              Icons.visibility_outlined,
              color: Colors.indigo,
            ),
            onPressed: onView,
          ),

        if (onEdit != null)
          IconButton(
            tooltip: "Edit",
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.orange,
            ),
            onPressed: onEdit,
          ),

        if (onDelete != null)
          IconButton(
            tooltip: "Delete",
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: onDelete,
          ),
      ],
    );
  }
}