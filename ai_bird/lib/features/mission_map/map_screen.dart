import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오늘의 미션 지도')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 20),
            Text('여기에 미션 노드들이 표시됩니다.', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
