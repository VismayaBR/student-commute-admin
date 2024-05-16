import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_commute_admin/const.dart';

class CustomeMargin extends StatelessWidget {
  Widget child;
  CustomeMargin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          child: child),
      Positioned(
        top: 20,
        left: 23,
        child: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Iconsax.element_24,
              color: WHITE,
            ),
          );
        }),
      )
    ]);
  }
}
