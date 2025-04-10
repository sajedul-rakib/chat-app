import 'dart:developer';
import 'package:chat_app/shared/shared.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketRepository {
  late io.Socket _socket;
late  String userId;

  SocketRepository() {
     userId= SharedData.userId ?? '';
    _socket = io.io(
      dotenv.env['BASE_URL'],
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
  }

  void connect() {
    _socket.connect();
      log(userId);
    _socket.emit("user_online",{'userId':userId,"isOnline":true});

    _socket.onConnectError((err) {
      log(err.toString());
    });
  }

  void disconnect() {
    if (_socket.connected) {
      _socket.emit('user_offline', {"userId":userId});
      _socket.disconnect();
    }
  }
}
