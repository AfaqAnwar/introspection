import 'package:cross_file_image/cross_file_image.dart';
import 'package:datingapp/components/registration_components/photo_picker_box.dart';
import 'package:datingapp/data/user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderables/reorderables.dart';

class PhotoTab extends StatefulWidget {
  final User currentUser;
  final Function() updateIndex;
  const PhotoTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<PhotoTab> createState() => PhotoTabState();
}

class PhotoTabState extends State<PhotoTab> {
  late ImagePicker picker;
  List<Widget> photoPickerBoxes = [];
  int index = -1;

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
    buildBoxes();
  }

  void buildBoxes() {
    for (int i = 0; i < 6; i++) {
      photoPickerBoxes.add(PhotoPickerBox(
        onTap: () {
          index = i;
          showImagePickerBottomBar();
        },
      ));
    }
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
          child: ReorderableWrap(
            spacing: 15,
            runSpacing: 15,
            onNoReorder: (int index) {
              //this callback is optional
              debugPrint(
                  '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
            },
            onReorderStarted: (int index) {
              //this callback is optional
              debugPrint(
                  '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
            },
            onReorder: (int oldIndex, int newIndex) {},
            children: photoPickerBoxes,
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

  void showImagePickerBottomBar() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoPopupSurface(
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoActionSheetAction(
                  child: Text(
                    'Choose from Library',
                    style: TextStyle(color: AppStyle.red500),
                  ),
                  onPressed: () async {
                    XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      updateWidgetTreeWithPhoto(image!);
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text(
                    'Take Photo',
                    style: TextStyle(color: AppStyle.red500),
                  ),
                  onPressed: () async {
                    XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppStyle.red800),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void updateWidgetTreeWithPhoto(XFile image) {
    setState(() {
      photoPickerBoxes[index] = GestureDetector(
        onTap: () {
          // fix replacing correct image.
          showImagePickerBottomBar();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: (Image(
              fit: BoxFit.fill,
              height: 100,
              width: 100,
              image: XFileImage(image))),
        ),
      );
    });
  }
}
