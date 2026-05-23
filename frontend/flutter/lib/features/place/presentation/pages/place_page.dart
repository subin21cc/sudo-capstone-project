import 'package:flutter/material.dart';

class PlacePage extends StatelessWidget {
  const PlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Place')),
      body: const Center(
        child: Text('Place (placeholder, Google Maps in Stage 4)'),
      ),
    );
  }
}
