import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:student_commute_admin/const.dart';

class BusesSlideShow extends StatelessWidget {
  const BusesSlideShow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width * .6,
      child: CarouselSlider.builder(
          unlimitedMode: true,
          slideTransform:const CubeTransform(),
          enableAutoSlider: true,
          slideBuilder: (index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                bus,
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: 4),
    );
  }
}
