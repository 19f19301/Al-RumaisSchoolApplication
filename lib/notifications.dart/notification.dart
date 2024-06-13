import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Notifications').snapshots();
  List colors_ = [
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.red,
    Colors.brown,
    Colors.purple,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.red,
    Colors.brown,
    Colors.purple,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.red,
    Colors.brown,
    Colors.purple,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.red,
    Colors.brown,
    Colors.purple,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
            stream: _usersStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("loading................");
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    int notification = index + 1;
                    return Card(
                      child: ListTile(
                        leading: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: colors_[index],
                              shape: BoxShape.circle,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white)),
                          child: Center(
                              child: Text(
                            notification.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          )),
                        ),
                        title: Text(
                          "${snapshot.data!.docs[index]['title']}",
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${snapshot.data!.docs[index]['subtitle']}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  });
            }),
      )),
    );
  }
}
