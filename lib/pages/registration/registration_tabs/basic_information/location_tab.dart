import 'package:datingapp/data/user.dart';
import 'package:flutter/material.dart';

class LocationTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const LocationTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<LocationTab> createState() => LocationTabState();
}

class LocationTabState extends State<LocationTab> {
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
  }

  void updateLocationOfUser() {}

  String getErrorMessage() {
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Where do you live?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Marlide-Display',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
