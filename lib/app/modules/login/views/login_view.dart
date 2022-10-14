import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moovbe/app/data/app_colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            width: width,
            color: AppColors.primaryColor,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/images/p1.png'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(color: Colors.white, fontSize: 41),
                        ),
                        Text(
                          'Manage your Bus and Drivers',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
            child: Column(
              children: [
                CustomTextField(
                  controller: controller.unameController,
                  hint: 'Enter Username',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: controller.passController,
                  hint: 'Enter Password',
                  isObscure: true,
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 50),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.accentColor)),
                      onPressed: () {
                        controller.login();
                      },
                      child: Text(
                        'Login',
                        // style: TextStyle(color: AppColors.accentColor),
                      )),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}

class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final bool? isObscure;
  final TextInputType? type;

  const CustomTextField(
      {super.key,
      this.hint,
      required this.controller,
      this.isObscure,
      this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(39, 42, 42, 42)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          keyboardType: type == null ? TextInputType.text : type,
          obscureText: isObscure == null ? false : isObscure!,
          decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        ),
      ),
    );
  }
}
