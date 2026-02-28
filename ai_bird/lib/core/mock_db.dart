// lib/core/mock_db.dart
final Map<String, dynamic> mockUser = {
  "uid": "test_user_01",
  "xp_total": 0,
  "owned_birds": ["sparrow"]
};

// Developer will dynamically plug in the demo presentation missions here
final List<Map<String, dynamic>> mockMissions = [
  {
    "id": "m_1",
    "type": "TEXT_COACH",
    "reward": 500,
    "title": "첫 질문 해보기",
    "ui_hint": "날씨를 물어보세요"
  }
];
