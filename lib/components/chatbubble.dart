class ChatBubble {
  // Chat bubbles would have the following the text prompt and if they are the current user
  String messageText;
  bool isCurrentUser;

  ChatBubble({required this.messageText, required this.isCurrentUser});

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
}
