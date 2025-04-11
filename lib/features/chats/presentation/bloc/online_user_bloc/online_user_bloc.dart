
import 'package:chat_app/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'online_user_event.dart';

part 'online_user_state.dart';

class OnlineUserBloc extends Bloc<OnlineUserEvent, OnlineUserState>
    with WidgetsBindingObserver {
  late final io.Socket _socket;
  final Map<String, bool> _onlineUser = {};

  OnlineUserBloc() : super(OnlineUserInitial()) {
    on<ConnectToSocket>((event, emit) {
      _socket = io.io(
        dotenv.env['BASE_URL'],
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build(),
      );

      // Connect socket
      _socket.connect();

      _socket
          .emit("user_online", {'userId': SharedData.userId, "isOnline": true});

      _socket.on("online_user", (data) {
        data.forEach((key, value) {
          add(UserOnlineStatusChanged(key, value));
        });
      });
    });

    on<UserOnlineStatusChanged>((event, emit) {
      _onlineUser[event.userId] = event.isOnline;
      emit(OnlineUsersUpdated(Map<String, bool>.from(_onlineUser)));
    });
  }

  @override
  Future<void> close() {
    _socket.emit('user_offline', {"userId": SharedData.userId});
    _socket.disconnect();
    return super.close();
  }
}
