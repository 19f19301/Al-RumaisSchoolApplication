import 'package:flutter/material.dart';
import 'package:school/search/VideoListItem.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List video_ = [
    {
      "video": "TMubSggUOVE",
      "title":
          "Math Videos: How To Learn Basic Arithmetic Fast - Online Tutorial Lessons"
    },
    {"video": "vV7C7bXm4VI", "title": "Math Antics - Number Patterns"},
    {"video": "ZQ7DuyUfauY", "title": "Grade 4 Math 5.6, What are Patterns and Terms"},
    {"video": "2-sP854NMLw", "title": "Long Division. DMSB. Grade 4"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "Lessons Records",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 30, top: 10, left: 10, right: 10),
        child: ListView.builder(
          itemCount: video_.length,
          itemBuilder: (context, index) {
            return VideoListItem(
              videoUrl: video_[index]["video"]!,
              title: video_[index]["title"]!,
            );
          },
        ),
      ),
    );
  }
}
