import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final dynamic playlistProvider;

  @override
  void initState(){
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int index){
    playlistProvider.currentSongIndex = index;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SongPage()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title:  Text(
          'P L A Y L I S T',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold,),
          ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary ),
      ),
      drawer: const MyDrawer(),

      body: Consumer<PlaylistProvider>(
        builder: (context, value, child){
          //get playlist
          final List<Song> playlist = value.playlist;
          
          // list view
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index){
              //get song
              final Song song = playlist[index];

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.imgPath),
                onTap: () => goToSong(index),
                );
            },
            );
        }
      ),
    );
  }
}