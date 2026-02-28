import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:ai_bird/core/state.dart';
import 'package:ai_bird/features/bird/bird_companion_widget.dart';

class GeminiMissionScreen extends StatefulWidget {
  const GeminiMissionScreen({super.key});

  @override
  State<GeminiMissionScreen> createState() => _GeminiMissionScreenState();
}

class _GeminiMissionScreenState extends State<GeminiMissionScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;

  void _submitMockMission() async {
    if (_isSubmitting) return;

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
        title: const Text('🎉 새로운 미션 성공!'),
        content: const Text('+500 XP를 획득했습니다.\n첨부 메뉴를 성공적으로 사용하셨습니다!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.clear();
              currentBirdState.value = BirdState.idle; // Reset
            },
            child: const Text('닫기'),
          )
        ],
      ),
    );
  }

  void _showAttachmentModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top drag handle
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined, size: 28),
                  title: const Text('카메라', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.pop(context); // Close modal
                    _submitMockMission();    // trigger mission success
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image_outlined, size: 28),
                  title: const Text('갤러리', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.pop(context);
                    _submitMockMission();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.attach_file, size: 28),
                  title: const Text('파일', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.pop(context);
                    _submitMockMission();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_to_drive, size: 28),
                  title: const Text('Drive', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.pop(context);
                    _submitMockMission();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book_outlined, size: 28),
                  title: const Text('NotebookLM', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.pop(context);
                    _submitMockMission();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('두 번째 미션'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
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
              // Gemini Style Greeting
              const Text(
                '보람님, 안녕하세요\n무엇을 도와드릴까요?',
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  height: 1.3,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              const Text(
                '힌트: 하단의 + 버튼을 눌러보세요.',
                style: TextStyle(fontSize: 16, color: Colors.teal, fontWeight: FontWeight.w600),
              ),
              
              const Expanded(
                child: Center(
                  child: BirdCompanionWidget(),
                ),
              ),

              // Bottom Input mimicking Gemini Native UI
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4F9), // Light grayish blue from Gemini UI
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: const EdgeInsets.only(left: 4.0, right: 12.0, top: 4.0, bottom: 4.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.black87, size: 28),
                      onPressed: _isSubmitting ? null : _showAttachmentModal,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        enabled: !_isSubmitting,
                        decoration: const InputDecoration(
                          hintText: 'Gemini에게 물어보세요',
                          hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        onSubmitted: (_) => _submitMockMission(),
                      ),
                    ),
                    if (_isSubmitting)
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 24, height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    else ...[
                      IconButton(
                        icon: const Icon(Icons.mic_none, color: Colors.black87, size: 26),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.auto_awesome, color: Colors.indigo, size: 24),
                        onPressed: () {},
                      ),
                    ]
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
