import 'package:flutter/material.dart';

class ProfileRowTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  const ProfileRowTile(
      {super.key, required this.text, required this.icon, required this.onTap});

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
