import 'package:flutter/material.dart';

import 'package:oasis/screens/teacherApp/home/teacher_home_view.dart';
import 'package:oasis/screens/teacherApp/profile/teacher_profile_view.dart';

class TeacherMainScreen extends StatefulWidget {
  TeacherMainScreen({this.tab});
  int tab;

  @override
  _TeacherMainScreenState createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {
  int _selectedIndex = 0;
  Widget _currentScreen;

  get selectedIndex => _selectedIndex;
  set selectedIndex(value) => setState(() => _selectedIndex = value);

  get currentScreen => _currentScreen;
  set currentScreen(value) => setState(() => _currentScreen = value);

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.tab;
    if (selectedIndex == 0) {
      currentScreen = TeacherHomeView();
    }
    if (selectedIndex == 1) {
      currentScreen = Container();
    }
    if (selectedIndex == 2) {
      currentScreen = Container();
    }

    if (selectedIndex == 3) {
      currentScreen = TeacherProfileView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: _buildTabBar(),
    );
  }

  BottomNavigationBar _buildTabBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'CLASSES',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pages),
          label: 'REPORTS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'CHAT',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.chat),
        //   label: 'CHAT',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'PROFILE',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    selectedIndex = index;

    if (selectedIndex == 0) {
      currentScreen = TeacherHomeView();
    }
    if (selectedIndex == 1) {
      currentScreen = Container();
    }
    if (selectedIndex == 2) {
      currentScreen = Container();
    }

    if (selectedIndex == 3) {
      currentScreen = TeacherProfileView();
    }
  }
}
