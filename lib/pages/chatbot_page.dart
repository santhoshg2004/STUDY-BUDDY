import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotPage extends StatefulWidget {
  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = [
    {"role": "bot", "message": "Hello! How can I assist you today?"},
  ];

  Future<void> sendMessage(String text) async {
    setState(() {
      _messages.add({"role": "user", "message": text});
    });
    _controller.clear();

    final response = await getChatbotResponse(text);

    setState(() {
      _messages.add({"role": "bot", "message": response});
    });
  }

  Future<String> getChatbotResponse(String prompt) async {
    const apiKey = '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'; // replace with your actual key
    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are Study Buddy, an educational assistant."},
          {"role": "user", "content": prompt}
        ],
        "max_tokens": 150,
      }),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['choices'][0]['message']['content'].trim();
    } else {
      return "Sorry, I couldn't process your request.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Study Bot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index]['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _messages[index]['message'] ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Send a message...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
