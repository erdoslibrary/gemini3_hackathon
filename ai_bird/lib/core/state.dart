import 'package:signals/signals.dart';
import 'package:ai_bird/core/mock_db.dart';

// Global App State via Signals
final userXp = signal<int>(mockUser['xp_total'] as int);
final currentTabIndex = signal<int>(0); // 0: Map, 1: Mission, 2: Shop

// Enum for bird states
enum BirdState { idle, thinking, happy }
final currentBirdState = signal<BirdState>(BirdState.idle);
