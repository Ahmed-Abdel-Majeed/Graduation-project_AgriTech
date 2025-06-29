import 'dart:async';
import 'dart:io';
import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/chat_bubble.dart';
import '../models/message_model.dart';
import '../service/ai_chat_service.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final AiChatService _chatService = AiChatService();

  late FlutterSoundRecorder _recorder;
  bool _isSending = false;
  bool _isRecording = false;
  bool _isRecorderInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    _recorder = FlutterSoundRecorder();

    final micStatus = await Permission.microphone.request();
    if (micStatus != PermissionStatus.granted) {
      _showError('يرجى السماح بالوصول إلى الميكروفون');
      return;
    }

    await _recorder.openRecorder();
    setState(() => _isRecorderInitialized = true);
  }

  @override
  void dispose() {
    if (_isRecorderInitialized) {
      _recorder.closeRecorder();
    }
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add(Message(role: 'user', text: input));
      _controller.clear();
      _isSending = true;
    });

    try {
      final response = await _chatService.sendText(_messages, input);
      setState(() => _messages.add(response));
    } catch (e) {
      _showError("حدث خطأ أثناء إرسال الرسالة");
    } finally {
      setState(() => _isSending = false);
    }
  }

Future<void> _startRecording() async {
  if (!_isRecorderInitialized) return;

  try {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/audio_record.aac';

    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
      sampleRate: 16000,
      bitRate: 64000,
    );
    setState(() => _isRecording = true);
  } catch (e) {
    _showError("تعذر بدء التسجيل الصوتي: ${e.toString()}");
  }
}

  Future<void> _stopRecording() async {
    if (!_isRecorderInitialized) return;

    try {
      final path = await _recorder.stopRecorder();
      setState(() => _isRecording = false);

      if (path != null && File(path).existsSync()) {
        setState(() => _isSending = true);

        final fileBytes = await File(path).readAsBytes();
        final response = await _chatService.sendAudio(_messages, fileBytes);

        setState(() => _messages.add(response));
      }
    } catch (e) {
      _showError("حدث خطأ أثناء إيقاف التسجيل: ${e.toString()}");
    } finally {
      setState(() => _isSending = false);
    }
  }

  void _showError(String message) {
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
        imagePath: "assets/images/aichat.png",
        onBackPress: () {},
        title: "🤖 AgriBot",
        
      
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),
          if (_isSending) const LinearProgressIndicator(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: 20.w,),
                // IconButton(
                //   icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                //   color: _isRecording ? Colors.red : Colors.green[700],
                //   onPressed: _isRecording ? _stopRecording : _startRecording,
                // ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالة...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.green[700],
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}