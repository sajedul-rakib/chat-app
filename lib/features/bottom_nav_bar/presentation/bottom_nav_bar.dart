import 'package:chat_app/features/chats/presentation/pages/chat_screen.dart';
import 'package:chat_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _pages = [
    // ContactScreen(),
    const ChatScreen(),
    const ProfileScreen()
  ];

  int _currentIndex = 0;

  void _changeIndex(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          // selectedItemColor: const Color(0xff0F1828),
          // selectedIconTheme: const IconThemeData(size: 6),
          currentIndex: _currentIndex,
          elevation: 2,
          onTap: (index) {
            _changeIndex(index);
          },
          showUnselectedLabels: false,
          items: const [
            // BottomNavigationBarItem(
            //     activeIcon: Icon(FontAwesomeIcons.solidCircle),
            //     icon: Icon(CupertinoIcons.person_2),
            //     label: 'Contacts'),
            BottomNavigationBarItem(
                activeIcon: Icon(FontAwesomeIcons.solidCircle),
                icon: Icon(FontAwesomeIcons.rocketchat),
                label: 'Chat'),
            BottomNavigationBarItem(
                activeIcon: Icon(FontAwesomeIcons.solidCircle),
                icon: Icon(FontAwesomeIcons.ellipsis),
                label: 'More'),
          ]),
      body: _pages[_currentIndex],
    );
  }
}
