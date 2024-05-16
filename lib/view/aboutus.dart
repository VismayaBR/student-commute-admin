import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/buses_slide_show.dart';
import 'package:student_commute_admin/utils/drawer.dart';
import 'package:student_commute_admin/utils/margin.dart';
import 'package:student_commute_admin/utils/style.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: const CustomeDrawer(),
        body: CustomeMargin(
            child: Row(
          children: [
            const BusesSlideShow(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  children: [
                    Text(
                      "About Us",
                      style: poppiStyle(color: WHITE, fontSize: 22),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    const Expanded(child: SizedBox(child: Text("More than just an app, CommuteSmart is a community of students, educators, and parents committed to transforming the student commute experience. Whether you're a high schooler or a university student, our platform supports your journey to and from school with smart technology and a heart for sustainability.Download CommuteSmart today and take the first step towards a smarter, safer, and more sustainable commute!",style: TextStyle(fontSize: 15,color: Colors.white),))),
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
