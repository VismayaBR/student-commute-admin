import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/style.dart';
import 'package:student_commute_admin/view/aboutus.dart';
import 'package:student_commute_admin/view/add_fare.dart';
import 'package:student_commute_admin/view/buses.dart';
import 'package:student_commute_admin/view/complaint.dart';
import 'package:student_commute_admin/view/feredetails.dart';
import 'package:student_commute_admin/view/login_screen.dart';
import 'package:student_commute_admin/view/notification.dart';
import 'package:student_commute_admin/view/schedule.dart';

class CustomeDrawer extends StatelessWidget {
  const CustomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      elevation: 0,
      backgroundColor: Colors.transparent,
      width: size.width * .2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: size.width * .15,
            height: size.height * .7,
            decoration: const BoxDecoration(
                color: DEFAULT_BLUE_DARK,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tile("Buses", const Buses(), context),
                _tile("Schedule", const Schedule(), context),
                _tile("Add Fare", const AddFareDetails(), context),
                _tile("View Fare", const FareDetails(), context),
                _tile("Notification", const Notifications(), context),
                _tile("Complaints", const Complaints(), context),
                _tile("About Us", const AboutUs(), context),
                _tile("Logout", const LoginScreen(), context),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(title, route, context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => route,
        ));
      },
      child: ListTile(
        minLeadingWidth: 20,
        leading: Text(
          ".",
          style: GoogleFonts.teko(
              color: WHITE, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        title: Text(
          title,
          style: poppiStyle(color: WHITE),
        ),
      ),
    );
  }
}
