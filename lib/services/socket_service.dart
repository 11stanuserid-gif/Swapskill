import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../config/app_config.dart';
import 'storage_service.dart';

class SocketService {
  static IO.Socket? _socket;

  static Future<void> connect() async {
    final token = await StorageService.getAccessToken();
    if (token == null) return;

    _socket = IO.io(
      AppConfig.socket,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .enableAutoConnect()
          .enableReconnection()
          .build(),
    );

    _socket!.onConnect((_) => print('🔌 Socket connected'));
    _socket!.onDisconnect((_) => print('🔌 Socket disconnected'));
    _socket!.onError((e) => print('❌ Socket error: $e'));
  }

  static IO.Socket? get socket => _socket;

  static void joinChat(String chatId) => _socket?.emit('joinChat', chatId);
  static void leaveChat(String chatId) => _socket?.emit('leaveChat', chatId);

  static void sendMessage(Map<String, dynamic> data) =>
      _socket?.emit('sendMessage', data);

  static void typing(String chatId, bool isTyping) =>
      _socket?.emit('typing', {'chatId': chatId, 'isTyping': isTyping});

  static void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }
}
