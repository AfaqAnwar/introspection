import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:datingapp/data/custom_user.dart';
import 'package:datingapp/widgets/widgets.dart';
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

  Future checkIfImagesLoaded() {
    if (widget.user.getImages.isEmpty) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    parsedDOB =
        '${widget.user.getDob.split('-')[2]}-${widget.user.getDob.split('-')[0]}-${widget.user.getDob.split('-')[1]}';

    return FutureBuilder(
      future: checkIfImagesLoaded(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == true) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_visible == false) {
                      _visible = !_visible;
                      Future.delayed(const Duration(milliseconds: 8000), () {
                        setState(() {
                          _visible = !_visible;
                        });
                      });
                    }
                  });
                },
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(xFilePath))),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(100, 18, 32, 60),
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(3, 3),
                          )
                        ]),
                  ),
                  Container(
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
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 250),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.getFirstName,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                      '${AgeCalculator.age(DateTime.parse(parsedDOB)).years},',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(color: Colors.white)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.user.jobTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 250),
                          child: Row(
                            children: buildUserImages(),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
