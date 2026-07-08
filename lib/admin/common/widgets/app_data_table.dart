import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AppDataTable extends StatelessWidget {
  final List<DataColumn2> columns;
  final List<DataRow2> rows;

  final Widget? header;
  final Widget? footer;

  final double minWidth;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.header,
    this.footer,
    this.minWidth = 1300,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (header != null) header!,

          Expanded(
            child: DataTable2(
              minWidth: minWidth,

              columnSpacing: 22,
              horizontalMargin: 20,

              headingRowHeight: 56,
              dataRowHeight: 60,

              dividerThickness: .5,

              border: TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),

              headingRowColor: WidgetStateProperty.all(
                const Color(0xffF8FAFC),
              ),

              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xff374151),
              ),

              dataTextStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xff111827),
              ),

              columns: [
                const DataColumn2(
                  fixedWidth: 70,
                  label: Text("S.No"),
                ),

                ...columns,
              ],

              rows: rows,

              empty: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "No Records Found",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (footer != null)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
              child: footer!,
            ),
        ],
      ),
    );
  }
}