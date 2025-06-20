import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;
  final String title;

  const PdfViewerPage({required this.pdfPath, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}
