import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_nest/data/repository/repository.dart';
import 'package:sound_nest/ui/discovery/discovery.dart';
import 'package:sound_nest/ui/home/home.dart';
import 'package:sound_nest/ui/setting/setting.dart';
import 'package:sound_nest/ui/user/user.dart';

void main() async {
  runApp(MusicApp());
}


class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
      ),
      home: const MusicAppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MusicAppPage extends StatefulWidget {
  const MusicAppPage({super.key});

  @override
  State<MusicAppPage> createState() => _MusicAppPageState();
}

class _MusicAppPageState extends State<MusicAppPage> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    const AccountTab(),
    const SettingTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Music App'),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.album_rounded), label: 'Discovery'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),

          ],
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,),
        tabBuilder: (BuildContext context, int index){
          return _tabs[index];
        },
      ),
    );
  }
}

