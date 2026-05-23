import 'package:flutter/material.dart';

class MyHealthPage extends StatelessWidget {
  const MyHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Health')),
      body: const Center(child: Text('My Health (placeholder)')),
    );
  }
}
