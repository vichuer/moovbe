import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moovbe/app/data/app_colors.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.accentColor,
        child: Stack(
          children: [
            Center(
              child: Image.asset('assets/images/logo.png'),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.offNamed('login');
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(color: AppColors.accentColor),
                              )),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
