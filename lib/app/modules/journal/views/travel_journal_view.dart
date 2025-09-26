import 'package:flutter/material.dart';

class TravelJournalView extends StatelessWidget {
  const TravelJournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Journal')),
      body: const Center(child: Text('Travel Journal - Coming Soon!')),
    );
  }
}