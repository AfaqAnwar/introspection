import 'package:datingapp/auth/auth_page.dart';

import 'package:datingapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/swipe/swipe_bloc.dart';
import 'firebase_options.dart';
import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => SwipeBloc()..add(LoadUsersEvent(users: User.users)))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          theme: ThemeData(fontFamily: 'Modern-Era')),
    );
  }
}

/*

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


*/
