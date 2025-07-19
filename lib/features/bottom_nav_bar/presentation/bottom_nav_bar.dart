import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/chats/presentation/pages/chat_screen.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repo.dart';
import 'package:chat_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:chat_app/services/locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared/shared.dart';
import '../../chats/presentation/bloc/get_user_bloc/get_friend_list_bloc.dart';
import '../../chats/presentation/bloc/online_user_bloc/online_user_bloc.dart';
import '../../profile/presentation/bloc/profile_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with WidgetsBindingObserver {
  final ChatRepo chatRepo = getIt<ChatRepo>();
  final ProfileRepo profileRepo = getIt<ProfileRepo>();
  int _currentIndex = 0;
  final List<Widget> _pages = [const ChatScreen(), const ProfileScreen()];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void _changeIndex(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final bloc = context.read<OnlineUserBloc>();

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      bloc.socket?.emit("user_offline", {"userId": SharedData.userId});
      bloc.socket?.disconnect();
    } else if (state == AppLifecycleState.resumed) {
      bloc.socket?.connect();
      bloc.socket?.emit("user_online", {"userId": SharedData.userId});
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnlineUserBloc()..add(ConnectToSocket()),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 2,
          onTap: (index) {
            _changeIndex(index);
          },
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(FontAwesomeIcons.solidCircle),
                icon: Icon(FontAwesomeIcons.rocketchat),
                label: 'Chat'),
            BottomNavigationBarItem(
                activeIcon: Icon(FontAwesomeIcons.solidCircle),
                icon: Icon(FontAwesomeIcons.ellipsis),
                label: 'More'),
          ],
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => GetFriendListBloc(chatRepo: chatRepo)
              ..add(GetFriendListRequested()),
          ),
          BlocProvider(
            create: (_) => ProfileBloc(profileRepo: profileRepo)
              ..add(GetUserDetailRequired()),
          ),
        ], child: _pages[_currentIndex]),
      ),
    );
  }
}
