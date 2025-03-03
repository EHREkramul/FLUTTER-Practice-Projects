import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({required this.url, super.key});
  final String url;

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  String? localFilePath;
  String? totalPage;
  String? currentPage;

  Future<void> loadPDF() async {
    final response = await http.get(Uri.parse(widget.url));
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/temp.pdf');
    await file.writeAsBytes(response.bodyBytes);

    setState(() {
      localFilePath = file.path;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          localFilePath == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  PDFView(
                    backgroundColor: Colors.black,
                    filePath: localFilePath,
                    onRender: (pages) {
                      totalPage = pages.toString();
                    },
                    onPageChanged: (page, total) {
                      setState(() {
                        currentPage = (page!+1).toString();
                      });
                    },
                  ),
                  Text(totalPage!=null?'$currentPage/$totalPage':'',style: TextStyle(color: Colors.red, fontSize: 20),),
                ],
              ),
    );
  }
}
