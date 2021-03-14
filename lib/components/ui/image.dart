import 'package:flutter/material.dart';
import 'package:ctrl_fan_project/help/string.dart';

const defaultImage = 'aHR0cDovL2M5NTIwMnRqLmJnZXQucnUveW91X215X291ci5wbmc=';

Widget buildNetworkImage(String image, {double size: 65}) {
  final imageFormat = RegExp(r'(.png|.jpg)');

  if (image == null || image.length == 0) {
    image = base64decode(defaultImage);
  } else {
    image = base64decode(image.substring(3));
    image = imageFormat.hasMatch(image) ? image : base64decode(defaultImage);
  }

  return Container(
    alignment: Alignment.center,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      color: Colors.grey[100],
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Image.network(image, height: size, width: size)
      ),
    ),
  );
}