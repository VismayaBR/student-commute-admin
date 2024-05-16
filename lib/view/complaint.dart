import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_commute_admin/const.dart';
import 'package:student_commute_admin/utils/buses_slide_show.dart';
import 'package:student_commute_admin/utils/drawer.dart';
import 'package:student_commute_admin/utils/margin.dart';
import 'package:student_commute_admin/utils/style.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('complaints').get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<void> updateComplaintStatus(String docId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(docId)
          .update({'status': status});
    } catch (e) {
      print('Error updating status: $e');
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
                      "Complaints",
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
                            return const Center(child: Text('No complaints available'));
                          }

                          final complaints = snapshot.data!;

                          return ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(height: 20),
                            itemCount: complaints.length,
                            itemBuilder: (context, index) {
                              final complaint = complaints[index].data();
                              final docId = complaints[index].id;
                              final name = complaint?['username'] ?? 'Unknown';
                              final complaintText = complaint?['complaint'] ?? 'No details';
                              final status = complaint?['status'] ?? '0';

                              return ListTile(
                                leading: const CircleAvatar(),
                                title: Text(
                                  name,
                                  style: poppiStyle(color: WHITE),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      complaintText,
                                      style: poppiStyle(
                                        color: const Color.fromARGB(255, 181, 180, 180),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: status == '1'
                                              ? null
                                              : () async {
                                                  await updateComplaintStatus(docId, '1');
                                                  setState(() {});
                                                },
                                          child: Text(
                                            status == '1' ? "Accepted" : "Accept",
                                            style: poppiStyle(
                                              color: status == '1'
                                                  ? Colors.green
                                                  : const Color.fromARGB(255, 181, 180, 180),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                         ElevatedButton(
                                          onPressed: status == '2'
                                              ? null
                                              : () async {
                                                  await updateComplaintStatus(docId, '2');
                                                  setState(() {});
                                                },
                                          child: Text(
                                            status == '2' ? "Rejected" : "Reject",
                                            style: poppiStyle(
                                              color: status == '2'
                                                  ? Colors.red
                                                  : const Color.fromARGB(255, 181, 180, 180),
                                            ),
                                          ),
                                        ),
                                      ],
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
