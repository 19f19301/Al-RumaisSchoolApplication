import 'package:flutter/material.dart';
import 'package:school/data/data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
            SizedBox(
              height: 270,
              width: double.infinity,
              child: Image.asset(
                'assets/mm.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              top: 100,
              left: 50,
              child: Text(
                "Al-Rumais School",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.4),
              ),
            ),
            Positioned(
              top: 230.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  height: 700,
                  width: 412,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Activities",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 270,
                          width: 600,
                          child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: activities.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  child: Card(
                                    elevation: 1,
                                    shadowColor: Colors.red,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                         
                                          child: Image.asset(
                                            "${activities[index]["image"]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        Text(
                                          "${activities[index]["name"]}",
                                          style:const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Events",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 370,
                            width: 400,
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    child: Card(
                                      elevation: 1,
                                      shadowColor: Colors.red,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            height: 200,
                                           child:Image.asset(
                                            "${events[index]["image"]}",
                                            fit: BoxFit.cover,
                                          ),
                                          ),
                                          const SizedBox(
                                            width: 17,
                                          ),
                                          Text(
                                            "${events[index]["name"]}",
                                            style:const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
