import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:ai_bird/core/state.dart';
import 'package:lottie/lottie.dart';

class BirdCompanionWidget extends StatelessWidget {
  const BirdCompanionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the current bird state signal (Idle, Thinking, Happy)
    final state = currentBirdState.watch(context);

    // Default image size
    const double imageSize = 250.0;

    // Since we only have one Lottie json right now, we will render it for all states.
    // If you add bird_idle.json, bird_happy.json later, you can use a Switch statement here 
    // just like the old PNG logic!
    return Lottie.asset(
      'assets/images/birds/bird.json',
      width: imageSize,
      height: imageSize,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image, size: 50, color: Colors.grey),
              SizedBox(height: 8),
              Text(
                'Lottie JSON\n로드 실패',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        );
      },
    );
  }
}
