import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    //song 1
    Song(
      songName: 'Mudhal Nee Mudivum Nee',
      artistName: 'Darbuka Siva  Sid Sriram  Thamarai',
      imgPath:
          'assets/img/Mudhal Nee Mudivum Nee - Title Track Video  Darbuka Siva  Sid Sriram  Thamarai.jpg',
      songPath:
          'audio/Mudhal Nee Mudivum Nee - Title Track Video  Darbuka Siva  Sid Sriram  Thamarai.mp3',
    ),
    //song 2
    Song(
      songName: 'Paiya - Thuli Thuli  ',
      artistName: 'Yuvanshankar Raja ',
      imgPath:
          'assets/img/Paiya - Thuli Thuli Tamil Lyric  Yuvanshankar Raja  Karthi, Tamannaah.jpg',
      songPath:
          'audio/Paiya - Thuli Thuli Tamil Lyric  Yuvanshankar Raja  Karthi, Tamannaah.mp3',
    ),
    //song 3
    Song(
      songName: 'Minnadi Minnadi',
      artistName: ' K S Chithra',
      imgPath:
          'assets/img/Minnadi Minnadi  Video Lyrical  Naran  K S Chithra  Deepak Dev  Kaithapram  Mohanlal  Joshy.jpg',
      songPath:
          'audio/Minnadi Minnadi  Video Lyrical  Naran  K S Chithra  Deepak Dev  Kaithapram  Mohanlal  Joshy.mp3',
    ),
    Song(
      songName: 'Muttathengum',
      artistName: 'Franco  Sowmya  Shyam Dharman  Vayalar Sarathchandra Varma',
      imgPath:
          'assets/img/Muttathengum  Veruthe Oru Bharya  Franco  Sowmya  Shyam Dharman  Vayalar Sarathchandra Varma.jpg',
      songPath:
          'audio/Muttathengum  Veruthe Oru Bharya  Franco  Sowmya  Shyam Dharman  Vayalar Sarathchandra Varma.mp3',
    ),
    Song(
      songName: 'Neelathamare Neelathamara',
      artistName: ' Karthik  Vidyasagar  Vayalar Sarathchandra Varma',
      imgPath:
          'assets/img/Neelathamare  Neelathamara  Karthik  Vidyasagar  Vayalar Sarathchandra Varma.jpg',
      songPath:
          'audio/Neelathamare  Neelathamara  Karthik  Vidyasagar  Vayalar Sarathchandra Varma.mp3',
    ),
    Song(
      songName: 'Omal Kanmani  Naran',
      artistName: ' Deepak Dev  K S Chithra',
      imgPath:
          'assets/img/Omal Kanmani  Naran  Video Song  Mohanlal  Joshiy  Kaithapram  Deepak Dev  K S Chithra.jpg',
      songPath:
          'audio/Omal Kanmani  Naran  Video Song  Mohanlal  Joshiy  Kaithapram  Deepak Dev  K S Chithra.mp3',
    ),
    Song(
      songName: 'Sirivennela',
      artistName: ' Shyam Singha Roy',
      imgPath:
          'assets/img/Sirivennela (Female Version) - Lyric Video  Shyam Singha Roy  Nani, Sai Pallavi  Mickey J Meyer.jpg',
      songPath:
          'audio/Sirivennela (Female Version) - Lyric Video  Shyam Singha Roy  Nani, Sai Pallavi  Mickey J Meyer.mp3',
    ),
    Song(
      songName: 'Sneham Cherum Neram',
      artistName: 'Hesham Abdul Wahab, Hisham, and Rinu Razak',
      imgPath:
          'assets/img/Sneham Cherum Neram Official Full Song with Lyrics  Ohm Shanthi Oshaana.jpg',
      songPath:
          'audio/Sneham Cherum Neram Official Full Song with Lyrics  Ohm Shanthi Oshaana.mp3',
    ),
    Song(
      songName: 'Theerame',
      artistName: '  Sushin Shyam  Anwar Ali  K.S Chithra  Sooraj Santhosh',
      imgPath:
          'assets/img/Theerame Lyrical Video  Malik  Sushin Shyam  Anwar Ali  K.S Chithra  Sooraj Santhosh.jpg',
      songPath:
          'audio/Theerame Lyrical Video  Malik  Sushin Shyam  Anwar Ali  K.S Chithra  Sooraj Santhosh.mp3',
    ),
    Song(
      songName: 'Venmegam',
      artistName: ' Joe Paul, K. S. Harisankar, and Nobin Paul',
      imgPath:
          'assets/img/Venmegam song malayalam Withe Lyrics-2018 movie song.jpg',
      songPath:
          'audio/Venmegam song malayalam Withe Lyrics-2018 movie song.mp3',
    ),
  ];

  //current song playing
  int? _currentSongIndex;

  // AUDIO PLAYER
  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentduration = const Duration();
  Duration _totalduration = const Duration();

  //constructor
  PlaylistProvider() {
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play song
  void play() async {
    final String path = _playlist[_currentSongIndex ?? 0].songPath;
    await _audioPlayer.stop(); // stop curent song
    await _audioPlayer.play(AssetSource(path)); // play new song
    _isPlaying = true;
    notifyListeners();
  }

  //pause song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume song
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // if not last song
        _currentSongIndex = _currentSongIndex! + 1;
        play();
      } else {
        // if last song
        _currentSongIndex = 0;
        play();
      }
    }
  }

  //play previous song
  void playPreviousSong() async {
    if (_currentduration.inSeconds > 5) {
      //if song is more than 5 seconds
      await _audioPlayer.seek(const Duration(seconds: 0));
    } else {
      if (_currentSongIndex! > 0) {
        // if not first song
        _currentSongIndex = _currentSongIndex! - 1;
        play();
      } else {
        // if first song
        _currentSongIndex = _playlist.length - 1;
        play();
      }
    }
  }

  //list to duration
  void listenToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalduration = newDuration;
      notifyListeners();
    });

    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newDuration) {
      _currentduration = newDuration;
      notifyListeners();
    });

    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //dispose audio player

  // GETTERS
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentduration;
  Duration get totalDuration => _totalduration;

  // SETTERS
  set currentSongIndex(int? index) {
    _currentSongIndex = index;

    if(index != null){
      play();
    }
    notifyListeners();
  }
}
