// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medicine_scheduler_app/controller/auth_controller.dart';
import 'package:medicine_scheduler_app/globals/global_vars.dart';
import 'package:medicine_scheduler_app/view/nav_bar_screen.dart';
import 'package:medicine_scheduler_app/view/widgets/custom_txtfield.dart';
import 'package:medicine_scheduler_app/view/widgets/login_button.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();

  String dropDownVal = "User"; //also called usertype
  final dropDownItem = ["User", "Family Member"];

  bool isRegisterPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: isRegisterPage
            ? Column(
                children: [
                  const Spacer(),
                  CustomTextField(
                      hintText: "Name",
                      controller: usernameController,
                      isobscure: false),
                  20.heightBox,
                  CustomTextField(
                      hintText: "Email",
                      controller: emailController,
                      isobscure: false),
                  20.heightBox,
                  CustomTextField(
                      hintText: "Password",
                      controller: passwordController,
                      isobscure: true),
                  50.heightBox,
                  loginButton("Register").onTap(() async {
                    String res = await AuthController().signUp(
                        usernameController.text,
                        emailController.text,
                        passwordController.text);
                    showSnackBar(res, context);
                    if (res == "Success creating account") {
                      nextScreenReplace(const NavBarScreeen(), context);
                    }
                  }),
                  10.heightBox,
                  "Already have an account?"
                      .text
                      .fontWeight(FontWeight.w300)
                      .make(),
                  2.heightBox,
                  "Login Now".text.fontWeight(FontWeight.bold).make().onTap(() {
                    setState(() {
                      isRegisterPage = false;
                    });
                  }),
                  const Spacer(),
                ],
              )
            : Column(
                children: [
                  const Spacer(),
                  CustomTextField(
                      hintText: "Email",
                      controller: emailController,
                      isobscure: false),
                  20.heightBox,
                  CustomTextField(
                      hintText: "Password",
                      controller: passwordController,
                      isobscure: true),
                  20.heightBox,
                  Row(
                    children: [
                      "I am :".text.make(),
                    ],
                  ),
                  3.heightBox,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: DropdownButton<String>(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(36),
                      underline: Container(),
                      isExpanded: true,
                      isDense: true,
                      hint: const Text("I am :"),
                      value: dropDownVal,
                      onChanged: (newValue) {
                        setState(() {
                          dropDownVal = newValue.toString();
                        });
                      },
                      items: dropDownItem.map(buildMenuItem).toList(),
                    ),
                  ),
                  50.heightBox,
                  loginButton("Log In").onTap(() async {
                    String res = await AuthController().loginUser(
                        emailController.text,
                        passwordController.text,
                        dropDownVal.toString());
                    showSnackBar(res, context);
                    if (res == "Success logging in") {
                      nextScreenReplace(const NavBarScreeen(), context);
                    }
                  }),
                  10.heightBox,
                  "Don't have an account?"
                      .text
                      .fontWeight(FontWeight.w300)
                      .make(),
                  2.heightBox,
                  "Register Now"
                      .text
                      .fontWeight(FontWeight.bold)
                      .make()
                      .onTap(() {
                    setState(() {
                      isRegisterPage = true;
                    });
                  }),
                  const Spacer(),
                ],
              ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
