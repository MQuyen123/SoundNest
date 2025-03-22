import 'package:flutter/material.dart';
import 'package:sound_nest/ui/home/view_model.dart';

import '../../data/model/song.dart';

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
  late  MusicAppViewModel _viewModel =  MusicAppViewModel();

  initState(){
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    observeData();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    bool showLoading = songs.isEmpty;
    if(showLoading){
      return getProgressBar();
    }
    else {
      return getListView();
    }
  }

  Widget getProgressBar(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getListView(){
    return ListView.separated(
      itemCount: songs.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        thickness: 1,
        indent: 20,
        endIndent: 20,
      ),
      itemBuilder: (context, position) {
         return getRow(position);
      }
    );
  }

  Widget getRow(int index){
    return Container(
      padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Image.network(songs[index].image, width: 50, height: 50,),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(songs[index].title),
                Text(songs[index].artist),
              ],
            ),
          ],
        ));
  }

  void observeData(){
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }
}

