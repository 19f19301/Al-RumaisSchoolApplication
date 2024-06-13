import 'package:flutter/material.dart';
import 'package:school/data/data.dart';

class PageViews extends StatefulWidget {
  const PageViews({super.key});

  @override
  State<PageViews> createState() => _PageViewsState();
}

class _PageViewsState extends State<PageViews> {
  int mySlideIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/signIn', (route) => false);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Expanded(
            child: PageView.builder(
                itemCount: ad.length,
                onPageChanged: (value) {
                  setState(() {
                    mySlideIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                       Image.asset(
                         ad[index]["image"],
                         height: 280,
                         fit: BoxFit.cover,
                       ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Center(
                        child: Text(
                          "Unlock Your Potential at Al-Rumais School",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.center,
                        child: Text(
                          ad[index]["Text"],
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  );
                }),
          ),
          SizedBox(
            height: 60,
            width: 300,
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ad.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 20,
                        width: index == mySlideIndex ? 40 : 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color:
                              index == mySlideIndex ? Colors.red : Colors.grey,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      )),
    );
  }
}
