import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  static const apiKey = "AIzaSyDh-ciS9qZ42yT4dd74ZoDJxGTPTrV5ek8";
  // تأكد من استخدام النموذج الصحيح كما فعلت
  final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
  final List<Message> _messages = [];
  bool _isLoading = false;

  Future<void> sendMessage() async {
    final String message = _userInput.text.trim();

    if (message.isEmpty) return;

    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
      _isLoading = true;
    });

    final List<String> arabicKeywords = [
      "من صمم التطبيق",
      "مصمم التطبيق",
      "من عمل التطبيق",
      "من قام بتطوير التطبيق",
      "من الذي برمج التطبيق",
      "من عمل هذا التطبيق",
      "من صنع التطبيق",
      "مصمم هذا التطبيق",
      "من صمم هذا التطبيق",
      "مين صمم التطبيق",
      "مين اللي صمم التطبيق",
      "مين اللي عمل التطبيق",
      "من قام بتطوير هذا التطبيق",
      "من انت",
    ];

    final List<String> englishKeywords = [
      "who designed the app",
      "who made the app",
      "who created the app",
      "who developed the app",
      "who built the app",
      "who is the app designer",
      "app creator",
      "app developer",
      "who programmed the app",
      "who created this application",
      "whos",
    ];

    if (arabicKeywords.any((keyword) => message.toLowerCase().contains(keyword.toLowerCase())) ||
        englishKeywords.any((keyword) => message.toLowerCase().contains(keyword.toLowerCase()))) {
      final bool isArabic = arabicKeywords.any(
          (keyword) => message.toLowerCase().contains(keyword.toLowerCase()));

      setState(() {
        _messages.add(Message(
          isUser: false,
          message: isArabic
              ? """
✨ مرحباً بك! ✨  
هذه الأداة تم تصميمها وتطويرها بواسطة فريق:  
 AgriTechX  
⚙️ مهمتنا:  
- توفير حلول ذكية ومبتكرة لدعم القطاع الزراعي باستخدام التكنولوجيا المتقدمة.  

📞 للتواصل:  
- رقم الهاتف: +20 123 456 7890  
- البريد الإلكتروني: info@agritechx.com  

🌐 حساباتنا:  
- LinkedIn: linkedin.com/in/agritechx  
- GitHub: github.com/agritechx  
- Twitter: twitter.com/agritechx  

🚀 نحن سعداء باستخدامك لهذه الأداة!  
"""
              : """
✨ Hello! ✨  
This tool was proudly designed and developed by:  
 AgriTechX  

⚙️ Our Mission:  
- Providing smart and innovative solutions to support the agricultural sector using advanced technology.  

📞 Contact Us:  
- Phone: +201501053538  
- Email: info@agritechx.com  

🌐 Social Media:  
- LinkedIn: linkedin.com/in/agritechx  
- GitHub: github.com/agritechx  
- Twitter: twitter.com/agritechx  

Thank you for using the tool!
""",
          date: DateTime.now(),
        ));
        _isLoading = false;
      });

      _userInput.clear();
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      return;
    }

    final content = [Content.text(message)];
    try {
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(Message(
          isUser: false, 
          message: response.text ?? "", 
          date: DateTime.now(),
        ));
        _isLoading = false;
      });
      _userInput.clear();
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } catch (e) {
      print("Error during generateContent: $e");
      setState(() {
        _messages.add(Message(
          isUser: false,
          message: "عذرًا، حدث خطأ أثناء معالجة الطلب: $e",
          date: DateTime.now(),
        ));
        _isLoading = false;
      });
      _userInput.clear();
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("AI Chat", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _userInput,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
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

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

/// Widget لتصميم فقاعات الدردشة
class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const ChatBubble({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white;
    final alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            message,
            textAlign: isUser ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                "$date • ${isUser ? "You" : "AgritechX"}",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey, thickness: 0.2),
        ],
      ),
    );
  }
}
