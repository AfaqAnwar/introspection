import 'package:cross_file_image/cross_file_image.dart';
import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerBox extends StatefulWidget {
  final int index;
  final CurrentUser currentUser;
  const PhotoPickerBox(
      {super.key, required this.index, required this.currentUser});

  @override
  State<PhotoPickerBox> createState() => _PhotoPickerBoxState();
}

class _PhotoPickerBoxState extends State<PhotoPickerBox> {
  late ImagePicker picker;
  late Widget currentWidget;

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
    buildTile();
  }

  void buildTile() {
    if (widget.currentUser.getImages.containsKey(widget.index)) {
      currentWidget = GestureDetector(
        onTap: () {
          showImagePickerBottomBarWithImageLoaded();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: (Image(
              fit: BoxFit.fill,
              height: 100,
              width: 100,
              image: XFileImage(widget.currentUser.getImages[widget.index]!))),
        ),
      );
    } else {
      currentWidget = GestureDetector(
        onTap: showImagePickerBottomBar,
        child: DottedBorder(
          color: Colors.grey.shade600,
          strokeWidth: 2,
          dashPattern: const [4, 4],
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Icon(Icons.add),
            ),
          ),
        ),
      );
    }
  }

  void updateUserImage(XFile image) {
    widget.currentUser.addImageAtIndex(widget.index, image);
  }

  void removeUserImage() {
    widget.currentUser.removeImageAtIndex(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return currentWidget;
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
                      updateUserImage(image!);
                      updateWidgetTreeWithPhoto(image);
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
                    setState(() {
                      updateUserImage(image!);
                      updateWidgetTreeWithPhoto(image);
                    });
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

  void showImagePickerBottomBarWithImageLoaded() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoPopupSurface(
          child: SizedBox(
            height: 300,
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
                      updateUserImage(image!);
                      updateWidgetTreeWithPhoto(image);
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
                    setState(() {
                      updateUserImage(image!);
                      updateWidgetTreeWithPhoto(image);
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text(
                    'Remove Photo',
                    style: TextStyle(color: AppStyle.red500),
                  ),
                  onPressed: () {
                    setState(() {
                      removeUserImage();
                      currentWidget = GestureDetector(
                        onTap: showImagePickerBottomBar,
                        child: DottedBorder(
                          color: Colors.grey.shade600,
                          strokeWidth: 2,
                          dashPattern: const [4, 4],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          child: const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      );

                      Navigator.pop(context);
                    });
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
      currentWidget = GestureDetector(
        onTap: () {
          showImagePickerBottomBarWithImageLoaded();
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
