import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    // Add welcome messages
    _messages.addAll([
      ChatMessage(
        text: "Hello! I'm AgroBot, your agricultural assistant. How can I help you today?",
        isUser: false,
        timestamp: DateTime.now(),
      ),
      ChatMessage(
        text: "I can help you with crop diseases, soil health, weather patterns, and farming best practices.",
        isUser: false,
        timestamp: DateTime.now(),
      ),
      ChatMessage(
        text: "Feel free to ask me anything about your crops!",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: _messageController.text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
    });

    // Simulate bot response
    _simulateBotResponse(userMessage.text);

    _messageController.clear();
    _scrollToBottom();
  }

  void _simulateBotResponse(String userMessage) {
    // Simple response simulation based on keywords
    String response = _generateResponse(userMessage.toLowerCase());

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _messages.add(ChatMessage(
          text: response,
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    });
  }

  String _generateResponse(String message) {
    if (message.contains('disease') || message.contains('pest')) {
      return "For crop diseases, I recommend:\n\n1. Regular monitoring of your crops\n2. Proper sanitation practices\n3. Use of disease-resistant varieties\n4. Integrated pest management\n\nCan you describe the symptoms you're seeing?";
    } else if (message.contains('soil') || message.contains('fertilizer')) {
      return "Soil health is crucial for good yields! Here are some tips:\n\n• Test your soil pH regularly\n• Use organic matter to improve soil structure\n• Rotate crops to maintain nutrients\n• Consider precision fertilizer application\n\nWhat type of soil do you have?";
    } else if (message.contains('weather') || message.contains('rain')) {
      return "Weather monitoring is essential for farming! I suggest:\n\n• Check weather forecasts regularly\n• Plan irrigation based on rainfall predictions\n• Protect crops during extreme weather\n• Use weather data for timing farm operations\n\nWhat weather concerns do you have?";
    } else if (message.contains('yield') || message.contains('production')) {
      return "To improve crop yields, consider:\n\n• Using high-quality seeds\n• Proper plant spacing\n• Adequate nutrition and water\n• Timely pest and disease control\n• Modern farming techniques\n\nWhich crop are you growing?";
    } else if (message.contains('irrigation') || message.contains('water')) {
      return "Water management is key to successful farming:\n\n• Use drip irrigation for efficiency\n• Monitor soil moisture levels\n• Water early morning or late evening\n• Mulch to reduce evaporation\n\nWhat's your current irrigation method?";
    } else {
      return "That's a great question! I'm here to help with all aspects of farming including:\n\n• Crop diseases and pests\n• Soil health and fertilizers\n• Weather and irrigation\n• Yield optimization\n• Market information\n\nCould you be more specific about what you'd like to know?";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Text(
                '🤖',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AgroBot', style: TextStyle(fontSize: 18)),
                Text(
                  'Ask Me Anything',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ask about your crop, soil, pests...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '🤖',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? AppTheme.primaryGreen
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppTheme.earthyBrown,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
