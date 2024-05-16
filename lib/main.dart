import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/controller/admin_controller.dart';
import 'package:student_commute_admin/firebase_options.dart';
import 'package:student_commute_admin/view/aboutus.dart';
import 'package:student_commute_admin/view/add_fare.dart';
import 'package:student_commute_admin/view/buses.dart';
import 'package:student_commute_admin/view/complaint.dart';
import 'package:student_commute_admin/view/feredetails.dart';
import 'package:student_commute_admin/view/home.dart';
import 'package:student_commute_admin/view/login_screen.dart';
import 'package:student_commute_admin/view/notification.dart';
import 'package:student_commute_admin/view/schedule.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminController>(
            create: (_) => AdminController())
      ],
      child: MaterialApp(
        title: 'STUDENT COMMUTE ADMIN',
        theme: ThemeData(
          scaffoldBackgroundColor: DEFAULT_BLUE_DARK,
          colorScheme: ColorScheme.fromSeed(seedColor: DEFAULT_BLUE_DARK),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
