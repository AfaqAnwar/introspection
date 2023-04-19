import 'package:flutter/cupertino.dart';

class UserChatModel {
  String name;
  String messageText;
  String imageURL;
  String time;
  UserChatModel(
      {required this.name,
      @required this.messageText,
      @required this.imageURL,
      @required this.time});
}
