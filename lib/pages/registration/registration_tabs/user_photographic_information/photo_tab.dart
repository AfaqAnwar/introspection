import 'package:datingapp/components/registration_components/photo_picker_box.dart';
import 'package:datingapp/data/CustomUser.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class PhotoTab extends StatefulWidget {
  final CustomUser currentUser;
  final Function() updateIndex;
  const PhotoTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<PhotoTab> createState() => PhotoTabState();
}

class PhotoTabState extends State<PhotoTab> {
  List<Widget> photoBoxes = [];
  String errorMessage = "Please upload at least 3 photos.";

  @override
  void initState() {
    super.initState();
    buildPhotoBoxes();
  }

  void buildPhotoBoxes() {
    for (int i = 0; i < 6; i++) {
      photoBoxes.add(PhotoPickerBox(index: i, currentUser: widget.currentUser));
    }
  }

  void swapPhotoBoxes(int oldIndex, int newIndex) {
    Widget temp = photoBoxes[oldIndex];
    photoBoxes[oldIndex] = photoBoxes[newIndex];
    photoBoxes[newIndex] = temp;
  }

  bool validatePhotos() {
    if (widget.currentUser.getImages.length >= 3) {
      return true;
    } else {
      return false;
    }
  }

  String getErrorMessage() {
    return errorMessage;
  }

  @override
  String toStringShort() {
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        Wrap(children: const [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Use your best photos!",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Marlide-Display',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          // NEED TO FIX THIS
          child: ReorderableWrap(
            spacing: 15,
            runSpacing: 15,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                swapPhotoBoxes(oldIndex, newIndex);
                widget.currentUser.swapImages(oldIndex, newIndex);
              });
            },
            children: photoBoxes,
          ),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Expanded(
                  child: Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child:
                      Icon(Icons.lightbulb_outline, color: Colors.grey[400])),
              Expanded(
                  child: Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              )),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Wrap(
            children: [
              Text(
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                  "Tap and hold to reorder your photos, be sure to add at least 3 photos to get the best results!")
            ],
          ),
        ),
      ],
    );
  }
}
