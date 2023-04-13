import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(children: [
          Expanded(
            child: SvgPicture.asset(
              "assets/logo-social.svg",
              height: 100,
            ),
          ),
          const Expanded(
            flex: 6,
            child: Text(
              '', //this is where "DISCOVER" went
              style: TextStyle(
                  fontSize: 50, color: Color.fromRGBO(189, 31, 54, 60)),
            ),
          )
        ]),
        actions: const [
          /* IconButton(
            onPressed: () {},
            icon: Icon(Icons.message),
            color: Color.fromRGBO(189, 31, 54, 60),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
            color: Color.fromRGBO(189, 31, 54, 60),
          )*/
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
