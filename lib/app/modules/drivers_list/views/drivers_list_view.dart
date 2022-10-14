import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moovbe/app/data/app_colors.dart';

import '../controllers/drivers_list_controller.dart';

class DriversListView extends GetView<DriversListController> {
  final DriversListController controller = Get.put(DriversListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Driver List'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                '21 Drivers Found',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Expanded(
                child: Obx(
              () => controller.drivers.value.driverList == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: controller.drivers.value.driverList == null
                          ? 0
                          : controller.drivers.value.driverList!.length,
                      itemBuilder: (ctx, index) => DriverListItem(
                        name: controller
                                    .drivers.value.driverList![index].name ==
                                null
                            ? ''
                            : controller.drivers.value.driverList![index].name!,
                        details: controller.drivers.value.driverList![index]
                                    .licenseNo ==
                                null
                            ? ''
                            : controller
                                .drivers.value.driverList![index].licenseNo
                                .toString(),
                        onPressed: () {
                          controller.deleteConfirm(controller
                              .drivers.value.driverList![index].id
                              .toString());
                        },
                      ),
                    ),
            )),
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
                            Get.toNamed('create-driver');
                          },
                          child: Text(
                            'Add Driver',
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

class DriverListItem extends StatelessWidget {
  final String name;
  final String details;

  final Function()? onPressed;

  const DriverListItem(
      {super.key, required this.name, required this.details, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 0.5)),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                child: Image.asset('assets/images/driver.png'),
              ),
              Expanded(
                child: ListTile(
                  title: Text(name),
                  subtitle: Text(details),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.accentColor)),
                    onPressed: onPressed,
                    child: Text('Delete')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
