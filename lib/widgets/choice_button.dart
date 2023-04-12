import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final IconData icon;
  final bool hasGradient;
  const ChoiceButton({
    Key? key,
    required this.width,
    required this.height,
    required this.size,
    required this.color,
    required this.icon,
    required this.hasGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          gradient: hasGradient
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Color.fromRGBO(189, 31, 54, 60),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(189, 31, 54, 60),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(3, 3),
            )
          ]),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
