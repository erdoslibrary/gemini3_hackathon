import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:ai_bird/core/state.dart';
import 'package:ai_bird/features/bird/bird_companion_widget.dart';

class RunnerScreen extends StatefulWidget {
  const RunnerScreen({super.key});

  @override
  State<RunnerScreen> createState() => _RunnerScreenState();
}

class _RunnerScreenState extends State<RunnerScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;

  void _submitMockMission() async {
    if (_controller.text.isEmpty) return;

    // 1. Hide keyboard
    FocusScope.of(context).unfocus();

    // 2. Set bird to Thinking
    setState(() => _isSubmitting = true);
    currentBirdState.value = BirdState.thinking;

    // 3. Simulate AI processing (2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    // 4. Reward XP and set bird to Happy
    userXp.value += 500;
    currentBirdState.value = BirdState.happy;
    setState(() => _isSubmitting = false);

    // 5. Show success dialog
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 미션 성공!'),
        content: const Text('+500 XP를 획득했습니다.\n새가 아주 기뻐합니다!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.clear();
              currentBirdState.value = BirdState.idle; // Reset bird to idle
            },
            child: const Text('다음 미션으로'),
          )
        ],
      ),
    );
  }

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mission Guidance
              const Text(
                '미션: 새에게 오늘 날씨를 물어보세요!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // The Bird
              const Expanded(
                child: Center(
                  child: BirdCompanionWidget(),
                ),
              ),

              const SizedBox(height: 40),

              // The Input
              TextField(
                controller: _controller,
                enabled: !_isSubmitting,
                decoration: InputDecoration(
                  hintText: '여기에 입력하세요...',
                  suffixIcon: _isSubmitting
                      ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          icon: const Icon(Icons.send, color: Colors.teal),
                          onPressed: _submitMockMission,
                        ),
                ),
                onSubmitted: (_) => _submitMockMission(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
