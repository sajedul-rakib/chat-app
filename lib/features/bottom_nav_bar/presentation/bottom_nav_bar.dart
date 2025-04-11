import 'package:chat_app/features/chats/presentation/pages/chat_screen.dart';
import 'package:chat_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../chats/presentation/bloc/online_user_bloc/online_user_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with WidgetsBindingObserver {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const ChatScreen(),
    const ProfileScreen()
  ];

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
    if(state==AppLifecycleState.detached){
      context.read<OnlineUserBloc>().close();
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
    return Scaffold(
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
      body: _pages[_currentIndex],
    );
  }
}
