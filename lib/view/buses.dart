import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/buses_slide_show.dart';
import 'package:student_commute_admin/utils/drawer.dart';
import 'package:student_commute_admin/utils/margin.dart';
import 'package:student_commute_admin/utils/style.dart';

class Buses extends StatefulWidget {
  const Buses({super.key});

  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('bus')
          .get();
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
      drawer: const CustomeDrawer(),
      body: CustomeMargin(
        child: Row(
          children: [
            const BusesSlideShow(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  children: [
                    Text(
                      "Buses",
                      style: poppiStyle(color: WHITE, fontSize: 22),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Expanded(
                      child: FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No buses available.'));
                          } else {
                            final busData = snapshot.data!;
                            return ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(height: 20),
                              itemCount: busData.length,
                              itemBuilder: (context, index) {
                                var bus = busData[index].data();
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: WHITE,
                                    child: Icon(
                                      Iconsax.bus5,
                                      color: DEFAULT_BLUE_DARK,
                                    ),
                                  ),
                                  title: Text(
                                    bus!['bus'],
                                    style: poppiStyle(color: WHITE),
                                  ),
                                  subtitle: Text(
                                    bus['reg_no'],
                                    style: poppiStyle(color: WHITE),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
