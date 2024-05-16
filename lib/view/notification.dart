import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/buses_slide_show.dart';
import 'package:student_commute_admin/utils/drawer.dart';
import 'package:student_commute_admin/utils/margin.dart';
import 'package:student_commute_admin/utils/style.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('feedback').get();
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
                      "Feedbacks",
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
                          }
                          if (snapshot.hasError) {
                            return const Center(child: Text('Error fetching data'));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No feedbacks available'));
                          }

                          final feedbacks = snapshot.data!;

                          return ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(height: 20),
                            itemCount: feedbacks.length,
                            itemBuilder: (context, index) {
                              final feedback = feedbacks[index].data();
                              final username = feedback!['userName'] ?? 'Anonymous';
                              final comment = feedback['feedback'] ?? 'No comment';
                              final rating = feedback['rating']?.toDouble() ?? 0.0;

                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: DEFAULT_BLUE_DARK,
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                                title: Text(
                                  username,
                                  style: poppiStyle(color: WHITE),
                                ),
                                subtitle: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        comment,
                                        style: poppiStyle(color: const Color.fromARGB(255, 181, 180, 180)),
                                      ),
                                    ),
                                    RatingStars(
                                      value: rating,
                                      maxValue: 5,
                                      starColor: Colors.amber,
                                      starSize: 20,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
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
