import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const routePath = '/Search';
  @override
  Widget build(BuildContext context) {
    print('📱 SearchScreen !!! ');
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: <Widget>[
          Text('SearchScreen'),
        ],
      ),
    );
  }
}
