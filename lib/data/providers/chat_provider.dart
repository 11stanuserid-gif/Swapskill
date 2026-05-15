import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> _chats = [];
  Map<String, List<MessageModel>> _messages = {};
  bool _isLoading = false;

  List<ChatModel> get chats => _chats;
  List<MessageModel> messagesFor(String chatId) => _messages[chatId] ?? [];
  bool get isLoading => _isLoading;

  Future<void> fetchChats() async {
    _isLoading = true;
    notifyListeners();
    try {
      final r = await ApiService.get('/chats');
      _chats = (r.data['data']['chats'] as List)
          .map((e) => ChatModel.fromJson(e)).toList();
    } catch (_) {}
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMessages(String chatId) async {
    try {
      final r = await ApiService.get('/chats/$chatId/messages');
      _messages[chatId] = (r.data['data']['messages'] as List)
          .map((e) => MessageModel.fromJson(e)).toList();
      notifyListeners();
    } catch (_) {}
  }

  Future<bool> sendMessage(String chatId, String content, {String type = 'text', String? mediaUrl}) async {
    try {
      final r = await ApiService.post('/chats/$chatId/messages', data: {
        'content': content, 'type': type, 'mediaUrl': mediaUrl,
      });
      final msg = MessageModel.fromJson(r.data['data']['message']);
      _messages[chatId] ??= [];
      _messages[chatId]!.add(msg);
      notifyListeners();
      return true;
    } catch (_) { return false; }
  }

  Future<void> markAsRead(String chatId) async {
    try {
      await ApiService.put('/chats/$chatId/read');
    } catch (_) {}
  }

  void addIncomingMessage(MessageModel msg) {
    _messages[msg.chatId] ??= [];
    _messages[msg.chatId]!.add(msg);
    notifyListeners();
  }
}
