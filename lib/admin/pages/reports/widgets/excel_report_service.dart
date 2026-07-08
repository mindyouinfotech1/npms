import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';

import '../model/station_report_model.dart';

class ExcelReportService {
  ExcelReportService._();

  //----------------------------------------------------------
  // Station Report
  //----------------------------------------------------------

  static Future<Uint8List> stationReport(
    List<StationReportModel> reports,
  ) async {
    final excel = Excel.createExcel();

    final sheet = excel["Station Report"];

    //--------------------------------------------------------
    // Heading
    //--------------------------------------------------------

    sheet.appendRow([
      TextCellValue("Station"),
      TextCellValue("Total QR"),
      TextCellValue("Visited"),
      TextCellValue("Missed"),
      TextCellValue("Compliance (%)"),
      TextCellValue("Total Officers"),
    ]);

    //--------------------------------------------------------
    // Data
    //--------------------------------------------------------

    for (final report in reports) {
      sheet.appendRow([
        TextCellValue(report.stationName),
        IntCellValue(report.totalQrPoints),
        IntCellValue(report.visitedQrPoints),
        IntCellValue(report.missedQrPoints),
        DoubleCellValue(report.compliance),
        IntCellValue(report.totalOfficers),
      ]);
    }

    //--------------------------------------------------------
    // Auto Width
    //--------------------------------------------------------

    for (int i = 0; i < 6; i++) {
      sheet.setColumnAutoFit(i);
    }

    final bytes = excel.encode();

    return Uint8List.fromList(bytes!);
  }

  //----------------------------------------------------------
  // Officer Report
  //----------------------------------------------------------

  static Future<void> officerReport() async {}

  //----------------------------------------------------------
  // Missed Patrol Report
  //----------------------------------------------------------

  static Future<void> missedReport() async {}

  //----------------------------------------------------------
  // Complete Report
  //----------------------------------------------------------

  static Future<void> completeReport() async {}
}