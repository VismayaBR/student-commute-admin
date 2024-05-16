import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/buses_slide_show.dart';
import 'package:student_commute_admin/utils/drawer.dart';
import 'package:student_commute_admin/utils/margin.dart';
import 'package:student_commute_admin/utils/style.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('bus_schedules').get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: CustomeDrawer(),
      body: CustomeMargin(
          child: Row(
        children: [
          BusesSlideShow(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                children: [
                  Text(
                    "Schedules",
                    style: poppiStyle(color: WHITE, fontSize: 22),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No schedules available.'));
                          } else {
                            final scheduleData = snapshot.data!;
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 20,
                              ),
                              itemCount: scheduleData.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: WHITE,
                                    child: Icon(
                                      Iconsax.bus5,
                                      color: DEFAULT_BLUE_DARK,
                                    ),
                                  ),
                                  title: Text(
                                    scheduleData![index]['bus'],
                                    style: poppiStyle(color: WHITE),
                                  ),
                                  subtitle: Text(
                                ' ${scheduleData![index]['from']} - ${scheduleData![index]['to']}',
                                    style: poppiStyle(color: WHITE),
                                  ),
                                  trailing: Text(
                                    scheduleData![index]['time'],
                                    style: poppiStyle(color: WHITE),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
