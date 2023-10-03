// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import '../../globals/colors.dart';

Widget loginButton(
  String text,
) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), gradient: myGradient),
    child: Stack(
      alignment: Alignment.center,
      children: [
        const Positioned(
          left: 10,
          child: Icon(Icons.lock_outline, color: Colors.white),
        ),
        Text(
          '$text',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
