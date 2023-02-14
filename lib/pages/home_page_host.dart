import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageHost extends StatefulWidget {
  const HomePageHost({super.key});

  @override
  State<HomePageHost> createState() => _HomePageHostState();
}

class _HomePageHostState extends State<HomePageHost> {
  @override
  void initState() {
    super.initState();
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
      ]),
      body: const Center(
        child: Text("You are logged in!"),
      ),
    );
  }
}
