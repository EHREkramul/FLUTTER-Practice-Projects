import 'package:flutter/material.dart';
import 'package:pdf_reader/pdfviewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> books = [
    {
      'title': 'Test PDF 1',
      'url':
          'https://www.ebl.com.bd/assets/home/schedule/SME-SOC-01-09-2024.pdf',
    },
    {
      'title': 'Test PDF 2',
      'url':
          'https://www.ebl.com.bd/assets/home/schedule/EBL_Corporate_Schedule_of_Charges_April_2024.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Reader'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => PDFViewer(url: books[index]['url'].toString()),)),
              title: Text(books[index]['title'].toString()),
              trailing: Icon(Icons.picture_as_pdf, color: Colors.redAccent,),
            ),
          );
        },
      ),
    );
  }
}
