import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/buses_slide_show.dart';
import 'package:student_commute_admin/utils/drawer.dart';
import 'package:student_commute_admin/utils/margin.dart';
import 'package:student_commute_admin/utils/style.dart';

class AddFareDetails extends StatefulWidget {
  const AddFareDetails({super.key});

  @override
  State<AddFareDetails> createState() => _AddFareDetailsState();
}

class _AddFareDetailsState extends State<AddFareDetails> {

  var from = TextEditingController();
  var to = TextEditingController();
  var rs = TextEditingController();
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Fare",
                    style: poppiStyle(color: WHITE, fontSize: 22),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From ',
                        style: GoogleFonts.poppins(color: WHITE),
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      TextFormField(

                          controller: from,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*required field";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            fillColor: WHITE,
                            filled: true,
                            isDense: true,
                            border: OutlineInputBorder(),
                          )),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Text(
                        'To ',
                        style: GoogleFonts.poppins(color: WHITE),
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      TextFormField(

                          controller: to,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*required field";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            fillColor: WHITE,
                            filled: true,
                            isDense: true,
                            border: OutlineInputBorder(),
                          )),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Text(
                        'Rs ',
                        style: GoogleFonts.poppins(color: WHITE),
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,

                          controller: rs,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*required field";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.currency_rupee_sharp),
                            fillColor: WHITE,
                            filled: true,
                            isDense: true,
                            border: OutlineInputBorder(),
                          )),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            // if (loginController.loginKey.currentState!.validate()) {
                            //   loginController.userLogin(
                            //     loginController.loginEmailController.text,
                            //     loginController.loginPasswordController.text,
                            //     context,
                            //   );
                            // }
                            addData();
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                              shape: MaterialStatePropertyAll<OutlinedBorder>(
                                  ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)))),
                              minimumSize: MaterialStatePropertyAll<Size>(
                                Size.fromHeight(50),
                              ),
                              backgroundColor:
                                  MaterialStatePropertyAll(DEFAULT_BLUE_GREY)),
                          child: Text(
                            'Update',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
  Future<void> addData() async {
      await FirebaseFirestore.instance.collection('bus_fare').add({
      
      'from': from.text,
      'to': to.text,
      'rs': rs.text,
    });
  }
}
