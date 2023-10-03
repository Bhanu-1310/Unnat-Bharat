// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:medicine_scheduler_app/controller/firebase_methods.dart';
import 'package:medicine_scheduler_app/globals/global_vars.dart';
import 'package:velocity_x/velocity_x.dart';

import '../globals/colors.dart';

class AddSOSNumberScreen extends StatefulWidget {
  const AddSOSNumberScreen({super.key});

  @override
  State<AddSOSNumberScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddSOSNumberScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add SOS Number".text.make(),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    hintText: "Name"),
                controller: nameController,
              ),
            ),
            20.heightBox,
            SizedBox(
              width: double.infinity,
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    hintText: "Enter Phone Number (Add Country Code)"),
                controller: phNumberController,
              ),
            ),
            const Spacer(),
            addNumberButton("Add Number").onTap(() async {
              String res = await FirebaseMethods().addPhoneNumber(
                  nameController.text, phNumberController.text, currentUserUid);
              showSnackBar(res, context);
            }),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

Widget addNumberButton(
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
