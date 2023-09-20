import 'package:art_wave/screens/homescreen.dart';
import 'package:art_wave/screens/post_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

final List<Widget> _pages = [
  const HomeScreen(),
  const CreateScreen(),
];

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const MainNavigationWeb();
    } else {
      if (Platform.isAndroid) {
        return const MainNavigationAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class MainNavigationAndroid extends StatefulWidget {
  const MainNavigationAndroid({super.key});

  @override
  State<MainNavigationAndroid> createState() => _MainNavigationAndroidState();
}

class _MainNavigationAndroidState extends State<MainNavigationAndroid> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 35,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create_new_folder_outlined, size: 35,),
            label: '',
          ),
        ],
      ),
    );
  }
}

class MainNavigationWeb extends StatelessWidget {
  const MainNavigationWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}


