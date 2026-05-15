import 'user_model.dart';

class ChatModel {
  final String id;
  final String userAId;
  final String userBId;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unread;
  final bool isBlocked;
  final UserModel? otherUser;

  ChatModel({
    required this.id,
    required this.userAId,
    required this.userBId,
    this.lastMessage,
    this.lastMessageAt,
    this.unread = 0,
    this.isBlocked = false,
    this.otherUser,
  });

  factory ChatModel.fromJson(Map<String, dynamic> j) => ChatModel(
        id: j['id'],
        userAId: j['userAId'],
        userBId: j['userBId'],
        lastMessage: j['lastMessage'],
        lastMessageAt: j['lastMessageAt'] != null ? DateTime.parse(j['lastMessageAt']) : null,
        unread: j['unread'] ?? 0,
        isBlocked: j['isBlocked'] ?? false,
        otherUser: j['otherUser'] != null ? UserModel.fromJson(j['otherUser']) : null,
      );
}

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String type;
  final String? content;
  final String? mediaUrl;
  final int? mediaDuration;
  final bool isRead;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.type = 'text',
    this.content,
    this.mediaUrl,
    this.mediaDuration,
    this.isRead = false,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> j) => MessageModel(
        id: j['id'],
        chatId: j['chatId'],
        senderId: j['senderId'],
        type: j['type'] ?? 'text',
        content: j['content'],
        mediaUrl: j['mediaUrl'],
        mediaDuration: j['mediaDuration'],
        isRead: j['isRead'] ?? false,
        createdAt: DateTime.parse(j['createdAt'] ?? DateTime.now().toIso8601String()),
      );
}
