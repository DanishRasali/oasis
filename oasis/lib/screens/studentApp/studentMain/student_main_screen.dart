import 'package:flutter/material.dart';

import 'package:oasis/screens/studentApp/home/student_home_view.dart';

// import 'package:motokar/screens/explore/explore_view.dart';
// import 'package:motokar/screens/trips/trips_view.dart';
// import 'package:motokar/screens/garage/garage_view.dart';
import 'package:oasis/screens/studentApp/profile/student_profile_view.dart';

class StudentMainScreen extends StatefulWidget {
  StudentMainScreen({this.tab});
  int tab;

  @override
  _StudentMainScreenState createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
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
      currentScreen = StudentHomeView();
    }
    if (selectedIndex == 1) {
      currentScreen = StudentHomeView();
    }
    if (selectedIndex == 2) {
      currentScreen = StudentHomeView();
    }

    if (selectedIndex == 3) {
      currentScreen = StudentProfileView();
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
          icon: Icon(Icons.home),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_task),
          label: 'TASKS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pages),
          label: 'RESULTS',
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
      currentScreen = StudentHomeView();
    }
    if (selectedIndex == 1) {
      currentScreen = StudentHomeView();
    }
    if (selectedIndex == 2) {
      currentScreen = StudentHomeView();
    }

    if (selectedIndex == 3) {
      currentScreen = StudentProfileView();
    }
  }
}
