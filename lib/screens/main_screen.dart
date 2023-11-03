import 'package:chat_app/screens/list_chat_screen.dart';
import 'package:chat_app/screens/contact_screen.dart';
import 'package:chat_app/screens/listfriend_screen.dart';
import 'package:chat_app/screens/story_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  int currentTitle = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();

  void _onItemTapped(int index) {
    setState(() {
      currentScreen = index;
      currentTitle = index;
    });
  }

  final title = [
    "Đoạn chat",
    "Cuộc gọi",
    "Danh sách bạn bè",
    "Tin",
  ];

  final screen = [
    ListChatScreen(),
    ListFriendScren(),
    ContactScreen(),
    StoryScreen(),
  ];

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                "Drawer Header",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                //
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                //
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color.fromRGBO(33, 138, 255, 1),
          ),
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
              //close drawer, if drawer is open
            } else {
              scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
            }
          },
        ),
        title: Text(title[currentTitle]),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          Container(
            width: 50,
            child: Image.asset("assets/icons/edit.png"),
          ),
        ],
      ),
      body: screen[currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentScreen,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(currentScreen == 0 ? 'assets/icons/chat-active.png' : 'assets/icons/chat-inactive.png'),
            label: 'Đoạn chat',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(currentScreen == 1 ? 'assets/icons/video-camera-active.png' : 'assets/icons/video-camera-inactive.png'),
            label: 'Cuộc gọi',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(currentScreen == 2 ? 'assets/icons/people-active.png' : 'assets/icons/people-inactive.png'),
            label: 'Danh bạ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(currentScreen == 3 ? 'assets/icons/book-active.png' : 'assets/icons/book-inactive.png'),
            label: 'Tin',
          ),
        ],
      ),
    );
  }
}
