import 'package:flutter/material.dart';

class ChatRoomListScreen extends StatelessWidget {
  const ChatRoomListScreen({super.key});
  static const routePath = '/ChatRoomList';
  @override
  Widget build(BuildContext context) {
    print('📱 ChatRoomListScreen !!! ');
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: <Widget>[
          Text('ChatRoomListScreen'),
        ],
      ),
    );
  }
}
