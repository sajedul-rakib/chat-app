import 'package:bloc/bloc.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'online_user_event.dart';
part 'online_user_state.dart';

class OnlineUserBloc extends Bloc<OnlineUserEvent, OnlineUserState>
    with WidgetsBindingObserver {
  io.Socket? socket;

  OnlineUserBloc() : super(OnlineUserInitial()) {
    on<ConnectToSocket>((event, emit) {
      if (socket?.connected == true) return;

      socket = io.io(
        dotenv.env['BASE_URL'],
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build(),
      );

      socket?.connect();
      socket?.emit("user_online", {"userId": SharedData.userId});

      socket?.on("online_user", (data) {
        add(UserOnlineStatusChanged(
            (data as List).map((e) => e.toString()).toList()));
      });
    });

    on<UserOnlineStatusChanged>((event, emit) {
      emit(OnlineUsersUpdated(event.onlineUser));
    });
  }

  @override
  Future<void> close() {
    socket?.emit('user_offline', {"userId": SharedData.userId});
    socket?.disconnect();
    return super.close();
  }
}
