import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/features/auth/command/auth_command.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  static const routePath = '/Profile';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authAsyncNotifierCommand.notifier).signOutEvent();
            },
          ),
        ],
      ),
      body: const Column(
        children: <Widget>[
          Text('ProfileScreen'),
        ],
      ),
    );
  }
}
