import 'dart:ffi';

import 'package:datingapp/widgets/user_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../widgets/choice_button.dart';
import '../widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Draggable(
            child: UserCard(user: User.users[0]),
            feedback: UserCard(user: User.users[0]),
            childWhenDragging: UserCard(user: User.users[1]),
            onDragEnd: (drag) {
              if (drag.velocity.pixelsPerSecond.dx < 0) {
                print("Swipe Left");
              } else {
                print("Swipe Right");
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceButton(
                    width: 60,
                    height: 60,
                    size: 25,
                    hasGradient: false,
                    color: Color.fromRGBO(189, 31, 54, 60),
                    icon: Icons.clear_rounded),
                ChoiceButton(
                    width: 80,
                    height: 80,
                    size: 30,
                    hasGradient: true,
                    color: Colors.white,
                    icon: Icons.favorite),
                ChoiceButton(
                    width: 60,
                    height: 60,
                    size: 25,
                    hasGradient: false,
                    color: Color.fromRGBO(189, 31, 54, 60),
                    icon: Icons.watch_later),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
