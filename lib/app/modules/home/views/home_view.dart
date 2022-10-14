import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moovbe/app/data/api_urls.dart';
import 'package:moovbe/app/data/app_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            height: 40,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  controller.logoutDialog();
                },
                icon: Icon(Icons.power_settings_new_rounded))
          ],
          bottom: PreferredSize(
            child: Container(),
            preferredSize: Size(0, 25),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: Card(
                    color: AppColors.accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: 200,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Image.asset('assets/images/bus.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bus',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Manage your Bus',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Get.toNamed('drivers-list');
                    },
                    child: Card(
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 200,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Driver',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Manage your Driver',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                controller.buses.value.busList == null
                    ? ''
                    : controller.buses.value.busList!.length.toString() +
                        ' Buses Found',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Expanded(
                child: Obx(
              () => controller.buses.value.busList == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: controller.buses.value.busList == null
                          ? 0
                          : controller.buses.value.busList!.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (ctx, index) => ListItem(
                        name: controller.buses.value.busList![index].name!,
                        details:
                            controller.buses.value.busList![index].seatCount!,
                        image: ApiUrls.busImageURL +
                            controller.buses.value.busList![index].image!,
                        onPressed: () {
                          Get.toNamed('bus-details', parameters: {
                            'seat': controller
                                .buses.value.busList![index].seatCount!,
                            'type':
                                controller.buses.value.busList![index].type!,
                            'driver': controller
                                .buses.value.busList![index].driver
                                .toString(),
                            'bus_id': controller.buses.value.busList![index].id
                                .toString()
                          });
                        },
                      ),
                    ),
            )),
          ],
        ));
  }
}

class ListItem extends StatelessWidget {
  final String name;
  final String details;
  final String image;
  final Function()? onPressed;

  const ListItem(
      {super.key,
      required this.name,
      required this.details,
      required this.image,
      this.onPressed});

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
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Container(
                  width: 90,
                  height: 90,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.jpg',
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
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
                    child: Text('Manage')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
