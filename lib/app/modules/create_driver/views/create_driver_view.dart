import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moovbe/app/data/app_colors.dart';
import 'package:moovbe/app/modules/login/views/login_view.dart';

import '../controllers/create_driver_controller.dart';

class CreateDriverView extends GetView<CreateDriverController> {
  final CreateDriverController controller = Get.put(CreateDriverController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Driver'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.nameController,
                      hint: 'Enter Name',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: controller.mobileController,
                      hint: 'Enter Mobile',
                      type: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: controller.licenseController,
                      hint: 'Enter License Number',
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
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.accentColor)),
                          onPressed: () {
                            controller.validateFields();
                          },
                          child: Text(
                            'Save',
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
