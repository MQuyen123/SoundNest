import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sound_nest/data/model/song.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.jsons';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final songWapper = jsonDecode(bodyContent) as Map;
      final songList = songWapper['songs'] as List;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      throw Exception('Failed to load data');
    }
}

}
class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final String response = await rootBundle.loadString('assets/song.json');
    final jsonBody = jsonDecode(response) as Map;
    final songList = jsonBody['songs'] as List;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    return songs;
  }
}