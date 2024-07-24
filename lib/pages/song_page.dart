import 'package:flutter/material.dart';
import 'package:music_app/components/neo_box.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // convert duration to minisec
  String formatTime( Duration dur){
    String twoDigitSec = dur.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${dur.inMinutes}:$twoDigitSec";

    return formattedTime;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
        builder: (context, value, child) {

          //get playlist
          final playlist = value.playlist;

          //get current song
          final currentSong = playlist[value.currentSongIndex ?? 0];

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //appbar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //back button
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        //title
                        const Text("P L A Y L I S T"),
                        //menu button
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 25,),
                    //artwork
                    NeoBox(
                        child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                            currentSong.imgPath,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //song name
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentSong.songName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                          overflow: TextOverflow.ellipsis,),
                                  Text(currentSong.artistName,
                                  overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ),
                            //heart icon
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          ],
                        ),
                      )
                    ])),

                    const SizedBox(height: 25),

                    //song duration
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //start time
                            Text(formatTime(value.currentDuration)),

                            //shuffle icon
                            const Icon(Icons.shuffle),

                            //repeat icon
                            const Icon(Icons.repeat),

                            //end time
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0),
                        ),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          onChanged: (double val) {},
                          onChangeEnd: (double val) {
                            //sliding has finished, go to the new position
                            value.seek(Duration(seconds: val.toInt()));
                          },
                        ),
                      )
                    ]),
                    const SizedBox(height: 25),

                    //controls
                    Row(
                      children: [
                        //skip prev
                        Expanded(
                            child: GestureDetector(
                                onTap: value.playPreviousSong,
                                child: const NeoBox(
                                    child: Icon(Icons.skip_previous)))),

                        const SizedBox(width: 25,),
                        //play & pause
                        Expanded(
                            child: GestureDetector(
                                onTap: value.pauseOrResume,
                                child: NeoBox(
                                    child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow)))),

                        const SizedBox(width: 25,),
                        //skip next
                        Expanded(
                            child: GestureDetector(
                                onTap: value.playNextSong,
                                child: const NeoBox(
                                    child: Icon(Icons.skip_next)))),
                      ],
                    )
                  ],
                ),
              ),
            )
            );
        }
            );
  }
}
