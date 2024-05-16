import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/buses_slide_show.dart';
import 'package:student_commute_admin/utils/drawer.dart';
import 'package:student_commute_admin/utils/margin.dart';
import 'package:student_commute_admin/utils/style.dart';

class FareDetails extends StatelessWidget {
  const FareDetails({super.key});

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('bus_fare').get();
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
                      "Fare Details",
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
                            return const Center(child: Text('No fare details available.'));
                          } else {
                            final fareData = snapshot.data!;
                            return DataTable(
                              dataTextStyle: const TextStyle(
                                color: WHITE,
                              ),
                              dataRowMinHeight: 25,
                              dataRowMaxHeight: 30,
                              border: TableBorder.all(color: WHITE),
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "From",
                                    style: poppiStyle(
                                      color: WHITE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "To",
                                    style: poppiStyle(
                                      color: WHITE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Rs",
                                    style: poppiStyle(
                                      color: WHITE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                              rows: fareData.map((doc) {
                                var data = doc.data();
                                return DataRow(cells: [
                                  DataCell(Text(data?['from'] ?? '')),
                                  DataCell(Text(data?['to'] ?? '')),
                                  DataCell(Text(data?['rs']?? '')),
                                ]);
                              }).toList(),
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
