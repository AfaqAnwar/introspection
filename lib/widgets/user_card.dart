import 'dart:async';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:introspection/data/custom_user.dart';
import 'package:introspection/style/app_style.dart';
import 'package:introspection/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserCard extends StatefulWidget {
  final CustomUser user;
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late String parsedDOB;
  late String xFilePath = xFilePath = widget.user.getImages[0]!.path;
  bool _visible = false;
  bool _textVisible = true;
  Timer _timer = Timer(const Duration(milliseconds: 8000), () {});

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    parsedDOB =
        '${widget.user.getDob.split('-')[2]}-${widget.user.getDob.split('-')[0]}-${widget.user.getDob.split('-')[1]}';

    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      if (_visible == false) {
                        _visible = !_visible;
                        _textVisible = _visible;
                        _timer = Timer(const Duration(milliseconds: 8000), () {
                          setState(() {
                            _visible = !_visible;
                            _textVisible = _visible;
                          });
                        });
                      }
                    });
                  }
                },
                child: Stack(children: [
                  Card(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(xFilePath))),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppStyle.red900,
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(2, 3),
                            )
                          ]),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _textVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          )),
                    ),
                  ),
                  Column(children: [
                    const Spacer(),
                    AnimatedOpacity(
                      opacity: _textVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      child: Wrap(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            '${widget.user.getFirstName}, ${AgeCalculator.age(DateTime.parse(parsedDOB)).years}',
                            style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Modern-Era',
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            widget.user.jobTitle,
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Modern-Era',
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 250),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 20),
                            child: Row(
                              children: buildUserImages(),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ])
                ]))));
  }

  List<Widget> buildUserImages() {
    Map<int, XFile> images = widget.user.getImages;
    List<Widget> imageWidgets = [];

    for (int i = 0; i < images.length; i++) {
      imageWidgets.add(GestureDetector(
          onTap: () {
            if (_visible) {
              setState(() {
                xFilePath = images[i]!.path;
              });
            }
          },
          child: UserImagesSmall(xfilePath: images[i]!.path)));
    }

    return imageWidgets;
  }
}
