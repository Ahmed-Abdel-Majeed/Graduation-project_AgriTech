import 'dart:convert';
import 'dart:typed_data';
import 'package:agri/core/constant/string.dart';
import 'package:agri/features/chat_bot/models/message_model.dart';
import 'package:dio/dio.dart';

class AiChatService {
  final Dio _dio = Dio();

  Future<Message> sendText(List<Message> chatMessages, String inputText) async {
    final formData = FormData.fromMap({
      'fullChat': jsonEncode([
        ...chatMessages,
        Message(role: 'user', text: inputText).toJson(),
      ]),
    });

    final response = await _dio.post('$baseUrl/aiagent/chat', data: formData);

    final data = response.data;
    return Message(role: 'model', text: data['response']);
  }


  Future<Message> sendAudio(
    List<Message> chatMessages,
    Uint8List audioBytes,
  ) async {
    final formData = FormData.fromMap({
      'audio': MultipartFile.fromBytes(audioBytes, filename: 'recording.aac'),
      'fullChat': jsonEncode(chatMessages.map((e) => e.toJson()).toList()),
    });

    final response = await _dio.post('$baseUrl/aiagent/chat', data: formData);

    final data = response.data;
    return Message(role: 'model', text: data['response']);
  }
}
