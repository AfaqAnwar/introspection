import 'package:flutter/material.dart';

class CupertinoPickerObject extends StatelessWidget {
  final String objectText;

  const CupertinoPickerObject({super.key, required this.objectText});

  String getObjectText() {
    return objectText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        objectText,
        style: const TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.normal),
      ),
    );
  }
}
