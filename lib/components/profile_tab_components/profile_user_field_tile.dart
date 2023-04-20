import 'package:flutter/material.dart';

class ProfileUserFieldTile extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final IconData? icon;
  const ProfileUserFieldTile(
      {super.key, required this.text, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: onTap,
      child: Column(children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Text(text,
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              Icon(icon, size: 18),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Divider(
          thickness: 0.5,
          color: Colors.grey[300],
        ),
      ]),
    );
  }
}
