import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoListItem extends StatelessWidget {
  final String videoUrl;
  final String title;

  VideoListItem({
    required this.videoUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),

           const SizedBox(height: 8.0),
            Builder(
              builder: (BuildContext context) {
                try {
                  return YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
                      flags:const YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    progressColors:const ProgressBarColors(
                      playedColor: Colors.blue,
                      handleColor: Colors.blueAccent,
                    ),
                  );
                } catch (error) {
                  // Handle the error gracefully
                  print('Error loading YouTube video: $error');
                  return const SizedBox(
                    width: double.infinity,
                    height: 200.0, // Adjust height as needed
                    child: Center(
                      child: Text(
                        'Error loading video',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
