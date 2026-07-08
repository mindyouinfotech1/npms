import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AppDataTableRow {
  static DataRow2 build({
    required int index,
    required List<Widget> cells,
    VoidCallback? onTap,
  }) {
    return DataRow2(
      onTap: onTap,

      color: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.blue.shade50;
        }

        return index.isEven
            ? Colors.white
            : const Color(0xffFAFAFA);
      }),

      cells: [
        DataCell(
          Text(
            "$index",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        ...cells.map(DataCell.new),
      ],
    );
  }
}