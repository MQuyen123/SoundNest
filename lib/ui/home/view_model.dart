import 'dart:async';
import '../../data/model/song.dart';
import '../../data/repository/repository.dart';

class MusicAppViewModel{
  StreamController<List<Song>> songStream = StreamController();

  void loadSongs() async{
    final repository = DefaultRepository();
    repository.loadData().then((songs) =>  songStream.add(songs!));
  }
}