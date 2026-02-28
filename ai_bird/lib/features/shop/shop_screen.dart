import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상점')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.store, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 20),
            Text('여기에 새 꾸미기 화면이 표시됩니다.', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
