// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_scheduler_app/controller/firebase_methods.dart';
import 'package:medicine_scheduler_app/globals/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../globals/global_vars.dart';

class ScheduledElements extends StatefulWidget {
  final dynamic snap;
  const ScheduledElements({super.key, required this.snap});

  @override
  State<ScheduledElements> createState() => _ScheduledElementsState();
}

class _ScheduledElementsState extends State<ScheduledElements> {
  showDeletePostOption(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.teal,
            title: const Text("Delete Task"),
            content: const Text("Are you sure to delete this?"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    String res = await FirebaseMethods()
                        .deletePost(widget.snap["postId"]);
                    if (res != "Failed") {
                      showSnackBar(res, context);
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.done,
                    color: Colors.white,
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat.yMMMMd().format(widget.snap['datePublished'].toDate());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19).copyWith(bottom: 17),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "${widget.snap["text"]}".text.size(20).make(),
            5.heightBox,
            const Divider(),
            5.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Reminder on ${widget.snap["reminderDate"]}"
                        .text
                        .size(13)
                        .make(),
                    "Scheduled on $formattedDate".text.size(13).make(),
                  ],
                ),
                "Delete".text.size(18).make().onTap(() {
                  showDeletePostOption(context);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
