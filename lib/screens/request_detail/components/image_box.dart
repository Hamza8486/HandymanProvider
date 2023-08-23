import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? imagePath;

  const ImageBox({Key? key,
    required this.imagePath,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: AssetImage(imagePath!,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
