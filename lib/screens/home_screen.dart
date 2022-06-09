import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/router/locations.dart';
import 'package:tomato_record/screens/chat/chat_list_page.dart';
import 'package:tomato_record/screens/home/items_page.dart';
import 'package:tomato_record/screens/home/map_page.dart';
import 'package:tomato_record/states/user_notifier.dart';
import 'package:tomato_record/widgets/expandable_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSeletedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomSeletedIndex,
        children: [
          ItemsPage(),
          (context.read<UserNotifier>().userModel == null)
              ? Container()
              : MapPage(context.read<UserNotifier>().userModel!),
          ChatListPage(),
          Container(
            color: Colors.accents[9],
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 90,
        children: [
          MaterialButton(
              onPressed: () {
                context.beamToNamed('/$LOCATION_INPUT');
              },
              shape: CircleBorder(),
              height: 40,
              color: Theme.of(context).colorScheme.primary,
              child: Icon(Icons.add)),
          MaterialButton(
              onPressed: () {},
              shape: CircleBorder(),
              height: 40,
              color: Theme.of(context).colorScheme.primary,
              child: Icon(Icons.add)),
        ],
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '초월읍',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.beamToNamed("/");
              },
              icon: Icon(CupertinoIcons.nosign)),
          IconButton(onPressed: () {
            context.beamToNamed('/$LOCATION_SEARCH');
          }, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSeletedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSeletedIndex == 0
                  ? 'assets/imgs/selected_home.png'
                  : 'assets/imgs/home.png')),
              label: '홈'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSeletedIndex == 1
                  ? 'assets/imgs/selected_location.png'
                  : 'assets/imgs/location.png')),
              label: '내 근처'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSeletedIndex == 2
                  ? 'assets/imgs/selected_chat.png'
                  : 'assets/imgs/chat.png')),
              label: '채팅'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSeletedIndex == 3
                  ? 'assets/imgs/selected_user.png'
                  : 'assets/imgs/user.png')),
              label: '내정보'),
        ],
        onTap: (index) {
          setState(() {
            _bottomSeletedIndex = index;
          });
        },
      ),
    );
  }
}
