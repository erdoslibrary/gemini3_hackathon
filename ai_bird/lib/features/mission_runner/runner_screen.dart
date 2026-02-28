import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:ai_bird/core/state.dart';

class RunnerScreen extends StatelessWidget {
  const RunnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('현재 미션'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                // Watch the reactive XP signal
                Text(
                  'XP: ${userXp.watch(context)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Text('여기에 메인 미션 화면이 구현됩니다.', style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
