import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moovbe/app/data/app_colors.dart';

import '../controllers/bus_details_controller.dart';

class BusDetailsView extends GetView<BusDetailsController> {
  const BusDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bus Details'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      controller.showAssignDialog();
                    },
                    child: Card(
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 150,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10)),
                                    child: Image.asset(
                                        'assets/images/driver.png')),
                              ),
                            ),
                            Obx(() => Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.drivername.value,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          controller.licenseno.value,
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.weekend_rounded,
                            color: AppColors.primaryColor,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.itemCount,
                                itemBuilder: (ctx, index) => Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(
                                        Icons.weekend_rounded,
                                        color: AppColors.accentColor,
                                        size: 40,
                                      ),
                                    )),
                          ),
                          if (controller.params['type'] == '1x3')
                            Expanded(child: Container()),
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.itemCount,
                                itemBuilder: (ctx, index) => Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(
                                        Icons.weekend_rounded,
                                        color: AppColors.accentColor,
                                        size: 40,
                                      ),
                                    )),
                          ),
                          if (controller.params['type'] == '2x2')
                            Expanded(child: Container()),
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.itemCount,
                                itemBuilder: (ctx, index) => Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(
                                        Icons.weekend_rounded,
                                        color: AppColors.accentColor,
                                        size: 40,
                                      ),
                                    )),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.itemCount,
                                itemBuilder: (ctx, index) => Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(
                                        Icons.weekend_rounded,
                                        color: AppColors.accentColor,
                                        size: 40,
                                      ),
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
