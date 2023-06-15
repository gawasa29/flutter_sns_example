import 'package:flutter/material.dart';
import 'package:flutter_sns_example/features/chat/view/chat_room_list_screen.dart';
import 'package:flutter_sns_example/features/notification/view/notification_screen.dart';
import 'package:flutter_sns_example/features/post/view/home_screen.dart';
import 'package:flutter_sns_example/features/search/view/search_screen.dart';
import 'package:flutter_sns_example/features/user/view/profile_screen.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({required this.child, super.key});

  final Widget child;
  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: ''),
          NavigationDestination(icon: Icon(Icons.search), label: ''),
          NavigationDestination(icon: Icon(Icons.notifications), label: ''),
          NavigationDestination(icon: Icon(Icons.mail), label: ''),
          NavigationDestination(icon: Icon(Icons.account_circle), label: ''),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              _selectedIndex = 0;
              context.go(HomeScreen.routePath);
            case 1:
              _selectedIndex = 1;
              context.go(SearchScreen.routePath);
            case 2:
              _selectedIndex = 2;
              context.go(NotificationScreen.routePath);
            case 3:
              _selectedIndex = 3;
              context.go(ChatRoomListScreen.routePath);
            case 4:
              _selectedIndex = 4;
              context.go(ProfileScreen.routePath);
            default:
              _selectedIndex = 0;
              context.go(HomeScreen.routePath);
          }
          setState(() {});
        },
      ),
      body: widget.child,
    );
  }
}
