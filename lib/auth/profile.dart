import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:school/auth/signIn.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Stream<DocumentSnapshot> getUserDataStream(String userId) {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    return docRef.snapshots();
  }

  Stream<DocumentSnapshot> getUserMarksStream(String userId) {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Marks').doc(userId);
    return docRef.snapshots();
  }

  Stream<DocumentSnapshot> getUserAttendanceStream(String userId) {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Attendance').doc(userId);

    return docRef.snapshots();
  }

  Stream<QuerySnapshot> getAttendanceRecordsStream(String userId) {
    return FirebaseFirestore.instance
        .collectionGroup('attendanceRecords')
        .snapshots();
  }

  Color? Attendance(double studentAttendance) {
    if (studentAttendance >= 0.0 && studentAttendance < 0.4) {
      return Colors.green;
    } else if (studentAttendance >= 0.4 && studentAttendance < 0.7) {
      return Colors.yellow;
    } else if (studentAttendance >= 0.7) {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red,
            elevation: 0.0,
            title: const Text(
              "Student Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            bottom: TabBar(
                indicatorColor: Colors.white,
                isScrollable: true,
                physics: const AlwaysScrollableScrollPhysics(),
                tabAlignment: TabAlignment.center,
                indicatorWeight: 5.8,
                labelColor: Colors.red[50],
                labelStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontSize: 18),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                tabs: const [
                  Tab(
                    iconMargin: EdgeInsets.all(10),
                    text: "Personal Date",
                  ),
                  Tab(
                    text: "Educational Data",
                  ),
                  Tab(
                    text: "Attendance Data",
                  ),
                ])),
        backgroundColor: Colors.red,
        body: TabBarView(
          children: [
            Stack(children: [
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder(
                        stream: getUserDataStream(
                            FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          Map<String, dynamic> userData =
                              snapshot.data!.data() as Map<String, dynamic>;

                          Timestamp birthdayTimestamp = userData['birthday'];
                          DateTime birthdayDate = birthdayTimestamp.toDate();
                          String formattedBirthday =
                              DateFormat('MMMM d, y - HH:mm')
                                  .format(birthdayDate);
                          return Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Center(
                                child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Image.asset("assets/student.png")),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Card(
                                elevation: 0.0,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  title: const Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    "${userData['full_name']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 0.0,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.email,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  title: const Text(
                                    "Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    "${userData['email']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 0.0,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.date_range,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  title: const Text(
                                    "Birthday",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    formattedBirthday,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 0.0,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.male,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  title: const Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    "${userData['gender']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 0.0,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.phone,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  title: const Text(
                                    "Phone",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    "${userData['phone_number']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                                },
                                child: const Card(
                                  elevation: 0.0,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.logout_outlined,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                      "LogOut",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      "Log out of this account",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ),
              )
            ]),
            Stack(children: [
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: StreamBuilder(
                        stream: getUserMarksStream(
                            FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          Map<String, dynamic> marksData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              const Center(child: Row()),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Student Marks:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mathematics:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "English:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Arts:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Technology:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Biology:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Chemistry:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Physics:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${marksData['Mathematics']}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "${marksData['English']}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "${marksData['Arts']}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "${marksData['Technology']}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "${marksData['Biology']}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "${marksData['Chemistry']}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "${marksData['Physics']}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Card(
                                  shadowColor: Colors.red,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.percent,
                                      color: Colors.red,
                                    ),
                                    title: const Text(
                                      "Percentage",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "${((marksData['Mathematics'] + marksData['English'] + marksData['Arts'] + marksData['Technology'] + marksData['Biology'] + marksData['Chemistry'] + marksData['Physics']) / 7)}%",
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        }),
                  ),
                ),
              )
            ]),
            Stack(children: [
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: StreamBuilder(
                      stream: getUserAttendanceStream(
                          FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("loading................");
                        }
                        Map<String, dynamic> attendanceData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        String percent_ = attendanceData['absence'].toString();
                        double percentPer = double.parse(percent_);

                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 35,
                                ),
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Attendance and Absence Policy*",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Align(
                                          child: ReadMoreText(
                                            'Warning System:\n'
                                            'If a students absences reach 4 days in a semester, they will receive'
                                            'a formal warning from the school administration.'
                                            'Upon accumulating 8 absences within the semester, the student will'
                                            'receive a second warning.\n'
                                            'Expulsion Threshold:*\n'
                                            'If a student reaches 11 absences within a semester without valid '
                                            "excuses, they will be subject to expulsion from the school.\n"
                                            "Procedure for Absence Reporting:\n"
                                            "Notification:*\n"
                                            "Parents or guardians are required to notify the school as soon"
                                            " as possible regarding the reason for a students absence. "
                                            "This notification should be sent on the day of absence."
                                            "Documentation:*\n"
                                            " A written excuse or medical note must be provided upon the "
                                            "students return to school for any absence lasting more"
                                            " than one day.\n"
                                            "Excused Absences:*\n"
                                            " Acceptable Reasons:*\n"
                                            " Absences due to illness or medical appointments require a note"
                                            " from a healthcare provider."
                                            " Family emergencies or bereavement."
                                            "School-approved educational activities or religious observances.\n"
                                            " Unexcused Absences:*\n"
                                            "Consequences:*\n"
                                            "Unexcused absences will be recorded and count towards the total "
                                            "absence tally."
                                            "Excessive unexcused absences may result in disciplinary action, "
                                            "including but not limited to detention or parental meetings.\n"
                                            "Appeals Process:*\n"
                                            " Appealing Absence Classification:*\n"
                                            "Students or parents may appeal the classification of an absence "
                                            "if they believe it was improperly categorized."
                                            "Appeals must be submitted within a reasonable timeframe after"
                                            " the absence.\n"
                                            " Attendance Monitoring:*\n"
                                            "Regular Review:*\n"
                                            "Attendance records will be regularly monitored by school"
                                            "administration to identify students at risk of exceeding"
                                            "the absence threshold."
                                            "Teachers and counselors will collaborate to provide support"
                                            "and intervention for students with attendance issues.\n"
                                            "Communication:*\n"
                                            "Parental Communication:*\n"
                                            " Regular communication will be maintained with parents or guardians"
                                            "regarding their childs attendance."
                                            "Parents will be informed promptly of any concerns related to their \n"
                                            "childs attendance.\n"
                                            "Documentation and Record-Keeping:\n"
                                            "Accurate Records:*\n"
                                            " Accurate and up-to-date attendance records will be maintained by the "
                                            "school administration."
                                            "Records will be securely stored and accessible to authorized personnel "
                                            "only.",
                                            trimMode: TrimMode.Line,
                                            trimLines: 8,
                                            colorClickableText: Colors.pink,
                                            trimCollapsedText: 'Show more',
                                            trimExpandedText: 'Show less',
                                            textAlign: TextAlign.justify,
                                            moreStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  height: 25,
                                ),
                                CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 12.8,
                                    percent: percentPer,
                                    center: Text("${percentPer * 100}"),
                                    footer: const Text(
                                      "\nAttends",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    animation: true,
                                    animationDuration: 1500,
                                    progressColor: Attendance(percentPer)),
                                const SizedBox(
                                  height: 25,
                                ),
                                SizedBox(
                                  height: 80,
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Excused Absence",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${attendanceData['attendance']}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Unexcused Absence",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${percentPer * 10}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                StreamBuilder(
                                    stream: getAttendanceRecordsStream(
                                        FirebaseAuth.instance.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }
                                      return SizedBox(
                                        width: 400,
                                        height: double.maxFinite,
                                        child: ListView.builder(
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                  leading: Text(
                                                      "${snapshot.data!.docs[index]['date']}"),
                                                  trailing: Text(
                                                      "${snapshot.data!.docs[index]['day']}"),
                                                  title: Text(
                                                      "${snapshot.data!.docs[index]['title']}"),
                                                  subtitle: Text(
                                                    "${snapshot.data!.docs[index]['subtitle']}",
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    })
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            ]),
          ],
        ),
      ),
    ));
  }
}
