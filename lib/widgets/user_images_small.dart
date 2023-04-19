import 'dart:io';

import 'package:flutter/material.dart';

class UserImagesSmall extends StatelessWidget {
  const UserImagesSmall({
    super.key,
    required this.xfilePath,
  });

  final String xfilePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, right: 8.0),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(xfilePath)),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
