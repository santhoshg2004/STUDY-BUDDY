import 'package:flutter/material.dart';
import 'pdf_viewer_page.dart';

class DbmsPage extends StatelessWidget {
  const DbmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> topics = [
      {'title': 'Introduction', 'pdf': 'assets/dbms_intro.pdf'},
      // Add other topics similarly later if you want
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('DBMS'),
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: ListView.separated(
        itemCount: topics.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              topics[index]['title']!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewerPage(
                    pdfPath: topics[index]['pdf']!,
                    title: topics[index]['title']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
