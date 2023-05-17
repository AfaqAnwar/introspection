import 'package:datingapp/components/chat_page_components/typing_indicator/typing_indicator.dart';

class ChatBubble {
  // Chat bubbles would have the following the text prompt and if they are the current user
  String messageText;
  bool isCurrentUser;
  TypingIndicator bubble;

  ChatBubble(
      {required this.messageText,
      required this.isCurrentUser,
      required this.bubble});

  // Setters and Getters functions
  String get getMessageText {
    return messageText;
  }

  set setMessageText(String messageText) {
    this.messageText = messageText;
  }

  bool get getCurrentUser {
    return isCurrentUser;
  }

  set setCurrentUser(bool isCurrentUser) {
    this.isCurrentUser = isCurrentUser;
  }

  TypingIndicator get getBubble {
    return bubble;
  }

  set setBubble(TypingIndicator bubble) {
    this.bubble = bubble;
  }

  void turnOffBubble() {
    setBubble = const TypingIndicator(showIndicator: false);
  }
}
