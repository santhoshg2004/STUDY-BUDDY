import 'package:flutter/material.dart';

class ProgrammingPage extends StatelessWidget {
  const ProgrammingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> topics = [
      'Introduction to Programming',
      'C Basics',
      'Java Basics',
      'Python Fundamentals',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROGRAM LANG'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFF1F6FA),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                topics[index],
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                // Handle tap here if needed
              },
            ),
          );
        },
      ),
    );
  }
}
