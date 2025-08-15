import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class FillPdfService {
  static Future<void> fillPdfForm({
    required String name,
    required String age,
    required String address,
    required String gender,
    required String id,
  }) async {
    // Load PDF template từ asset
    final data = await rootBundle.load('assets/01_01.pdf');
    final bytes = data.buffer.asUint8List();

    // Mở document
    final document = PdfDocument(inputBytes: bytes);
    final form = document.form;

    // Lặp qua từng field và gán giá trị
    for (int i = 0; i < form.fields.count; i++) {
      var field = form.fields[i];
      if (field is PdfTextBoxField) {
        if (field.name == 'HO_TEN') {
          field.text = name;
        } else if (field.name == 'NGAY_SINH') {
          field.text = age;
        } else if (field.name == 'DIA_CHI') {
          field.text = address;
        } else if (field.name == 'GIOI_TINH') {
          field.text = gender;
        } else if (field.name == 'CCCD') {
          field.text = id;
        }
      }
    }

    // Lưu file
    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/filled_form.pdf");
    await file.writeAsBytes(await document.save());
    document.dispose();

    // Mở file PDF vừa tạo
    if (Platform.isWindows) {
      await Process.run('start', [file.path], runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', [file.path]);
    }
  }
}
