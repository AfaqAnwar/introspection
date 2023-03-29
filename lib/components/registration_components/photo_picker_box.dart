import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PhotoPickerBox extends StatelessWidget {
  final Function()? onTap;
  const PhotoPickerBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget widget = const Icon(Icons.add);
    return GestureDetector(
      onTap: onTap!,
      child: DottedBorder(
        color: Colors.grey.shade600,
        strokeWidth: 2,
        dashPattern: const [4, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: SizedBox(
            height: 100,
            width: 100,
            child: widget,
          ),
        ),
      ),
    );
  }
}
