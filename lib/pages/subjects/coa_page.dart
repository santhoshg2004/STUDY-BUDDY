import 'package:flutter/material.dart';

class CoaPage extends StatelessWidget {
  const CoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> topics = [
      'Introduction',
      'Number Systems',
      'Processor',
      'Memory Hierarchy',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('COA'),
        actions: const [
          Icon(Icons.chevron_right),
          SizedBox(width: 12),
        ],
        backgroundColor: Colors.blueGrey.shade100,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: topics.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              topics[index],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Placeholder for topic detail navigation
            },
          );
        },
      ),
    );
  }
}
