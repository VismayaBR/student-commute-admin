import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/controller/admin_controller.dart';
import 'package:student_commute_admin/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loginEmailController = TextEditingController();
    TextEditingController loginPasswordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
          height: size.height / 2,
          width: size.width / 2,
          decoration: const BoxDecoration(color: WHITE),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height,
                width: size.width * .23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: WHITE,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(),
                    Text(
                      "Student Commute",
                      style: GoogleFonts.poppins(
                        color: DEFAULT_BLUE_DARK,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height,
                width: size.width * .23,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Center(
                        child: Text(
                          'Welcome',
                          style: GoogleFonts.robotoSerif(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        'Email',
                        style: GoogleFonts.poppins(),
                      ),
                      TextFormField(
                        controller: loginEmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*required field";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Text(
                        'Password ',
                        style: GoogleFonts.poppins(),
                      ),
                      Consumer<AdminController>(
                        builder: (context, obsecureController, _) {
                          return TextFormField(
                            obscureText: obsecureController.isObsecure,
                            controller: loginPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "*required field";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  obsecureController.changeObsecure();
                                },
                                icon: Icon(obsecureController.isObsecure
                                    ? Iconsax.eye
                                    : Iconsax.eye_slash),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text(
                            'Remember me',
                            style: GoogleFonts.poppins(),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password',
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login(context, loginEmailController, loginPasswordController);
                            }
                          },
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll<OutlinedBorder>(
                              ContinuousRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                            minimumSize: MaterialStatePropertyAll<Size>(
                              Size.fromHeight(50),
                            ),
                            backgroundColor: MaterialStatePropertyAll(DEFAULT_BLUE_GREY),
                          ),
                          child: Text(
                            'Login Now',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
    
     

   if (emailController.text == 'admin@gmail.com' && passwordController.text == 'admin@123') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful...'),
        ),
      );
      // Redirect to the admin home page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
      return;
    
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
        ),
      );
    }
  }
}
