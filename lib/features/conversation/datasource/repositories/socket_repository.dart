import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketRepository {
  late io.Socket _socket;

  SocketRepository(String token) {
    _socket = io.io(
      dotenv.env['BASE_URL'],
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );
  }

  void connect() {
    _socket.connect();
    _socket.onConnect((_) {
      _socket.emit('user_online', {'status': 'online'});
    });

    _socket.onConnectError((err) {
      log(err.toString());
    });
  }

  void disconnect() {
    if (_socket.connected) {
      _socket.emit('user_offline', {'status': 'offline'});
      _socket.disconnect();
    }
  }
}
