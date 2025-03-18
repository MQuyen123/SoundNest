import 'package:sound_nest/data/model/song.dart';
import 'package:sound_nest/data/source.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}
class DefaultRepository implements Repository {
  final _remoteDataSource = RemoteDataSource();
  final _localDataSource =  LocalDataSource();


  @override
  Future<List<Song>?> loadData() async {
    try {
      final remoteSongs = await _remoteDataSource.loadData();
      if (remoteSongs != null) {
        return remoteSongs;
      }
    } catch (e) {
      print('Remote data source failed: $e');
    }

    try {
      final localSongs = await _localDataSource.loadData();
      if (localSongs != null) {
        return localSongs;
      }
    } catch (e) {
      print('Local data source failed: $e');
    }

    return null;
  }
}