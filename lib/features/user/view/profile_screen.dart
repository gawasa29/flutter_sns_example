import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const routePath = '/Profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: <Widget>[
          Text('ProfileScreen'),
        ],
      ),
    );
  }
}
