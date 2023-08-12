import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicPlayer(),
    );
  }
}

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool isPlayingOn = false;
  double value = 0;
  final player = AudioPlayer();
  Duration? duration = const Duration(seconds: 0);

  void initPlayer() async {
    await player.setSource(AssetSource("assets/music1.mp3"));

    duration = await player.getDuration();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.play_arrow,
          size: 40,
          color: Colors.pink,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 134, 197, 198),
        title: const Text(
          "Music Streaming App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/tanvir.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 20),
              child: Container(
                color: Colors.black26,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.all(),
                child: Image.asset(
                  "assets/tanvir.jpg",
                  width: 250,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Summer Tanvir",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${(value / 60).floor()}:${(value % 60).floor()}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Slider.adaptive(
                    min: 0.0,
                    max: duration!.inSeconds.toDouble(),
                    value: value,
                    activeColor: Colors.amber,
                    onChanged: (value) {},
                  ),
                  Text(
                    "${duration!.inMinutes} : ${duration!.inSeconds}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.black87,
                  border: Border.all(color: Colors.pink),
                ),
                child: InkWell(
                  onTap: () async {
                    if (isPlayingOn) {
                      await player.pause();
                      setState(() {
                        isPlayingOn = false;
                      });
                    } else {
                      await player.resume();
                      setState(() {
                        isPlayingOn = true;
                      });

                      player.onPositionChanged.listen(
                        (position) {
                          setState(() {
                            value = position.inSeconds.toDouble();
                          });
                        },
                      );
                    }
                  },
                  child: Icon(
                    isPlayingOn ? Icons.play_arrow : Icons.pause,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Hello_World extends StatelessWidget {
  const Hello_World({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(" Hello World"),
    );
  }
}
