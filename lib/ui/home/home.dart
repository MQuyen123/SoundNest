import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_nest/ui/home/view_model.dart';

import '../../data/model/song.dart';
import '../now_playing/playing.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel = MusicAppViewModel();

  @override
  initState() {
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    observeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  @override
  dispose() {
    super.dispose();
    _viewModel.songStream.close();
  }

  Widget getBody() {
    bool showLoading = songs.isEmpty;
    if (showLoading) {
      return getProgressBar();
    } else {
      return getListView();
    }
  }

  Widget getProgressBar() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.separated(
      itemCount: songs.length,
      shrinkWrap: true,
      separatorBuilder:
          (context, index) => const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
      itemBuilder: (context, position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int index) {
    return _SongItemSection(parent: this, song: songs[index]);
  }

  void observeData() {
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }

  void showBottomSheet(Song song) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.grey.shade50,
            height: double.maxFinite,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Show bottom sheet for ${song.title}"),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close Button Sheet")),
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToSongDetail(Song song) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => NowPlaying(songs: songs, playingSong: song),
      ),
    );
  }
}

class _SongItemSection extends StatelessWidget {
  const _SongItemSection({required this.parent, required this.song});

  final _HomeTabPageState parent;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 20, right: 20),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/loading.jpg',
          image: song.image,
          width: 50,
          height: 50,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/loading.jpg',
              width: 50,
              height: 50,
            );
          },
        ),
      ),
      title: Text(
        song.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(song.artist),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: () {
          parent.showBottomSheet(song);
        },
      ),
      onTap: () {
        parent.navigateToSongDetail(song);
      },
    );
  }
}
