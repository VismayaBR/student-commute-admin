import 'package:flutter/material.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/drawer.dart';
import 'package:student_commute_admin/utils/margin.dart';
import 'package:student_commute_admin/utils/style.dart';

class Home extends StatelessWidget {
  Home({super.key});
  String image1 =
  "https://www.shutterstock.com/image-photo/bus-traveling-on-asphalt-road-600nw-1345741577.jpg";
  String image2 =
"https://www.shutterstock.com/image-photo/bus-traveling-on-asphalt-road-600nw-1345741577.jpg";
  String image3 =
"https://www.shutterstock.com/image-photo/bus-traveling-on-asphalt-road-600nw-1345741577.jpg";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(

    
      drawer:const CustomeDrawer(),
      body: CustomeMargin(
        child: Column(
          children: [
            imageHolder(size, image1),
            imageHolder(size, image2),
            imageHolder(size, image3),
            SizedBox(
              height: size.height * .05,
            ),
            Expanded(
                child: ListView.separated(
              itemCount: scheduleList.length,
              separatorBuilder: (context, index) => const SizedBox(
                width: 30,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  // height: 100,
                  width: size.width * .3,
                  child: Text(
                    scheduleList[index]["route"],
                    style: poppiStyle(
                      color: WHITE,
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget imageHolder(size, path) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: size.width,
      height: size.height * .18,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(path))),
    );
  }

  List<Map<String, dynamic>> scheduleList = [
    {
      "route": 'Perinthalmanna - Malappuram',
      "time": '12pm',
    },
    {
      "route": 'Perinthalmanna - Manjeri',
      "time": '10am',
    },
    {
      "route": 'Manjeri - Malappuram',
      "time": '3pm',
    },
    {
      "route": 'Perinthalmanna - Kozhikode',
      "time": '1pm',
    },
  ];
}
