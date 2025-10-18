// ChatMessageModel.dart

class ChatMessageModel {
  final String text;
  final String user;

  ChatMessageModel({
    required this.text,
    required this.user,
  });

  // From JSON (needed by FlutterFlow)
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['text'] as String,
      user: json['user'] as String,
    );
  }

  // To JSON (needed by FlutterFlow)
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'user': user,
    };
  }
}
