// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SOSshowcase extends StatelessWidget {
  final String contactName;
  final String phNumber;
  const SOSshowcase(
      {super.key, required this.contactName, required this.phNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      child: Row(
        children: [
          const CircleAvatar(
            child: Icon(Icons.account_circle_outlined),
          ),
          15.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$contactName".text.size(18).make(),
              3.heightBox,
              "$phNumber".text.make(),
            ],
          ),
        ],
      ),
    );
  }
}
