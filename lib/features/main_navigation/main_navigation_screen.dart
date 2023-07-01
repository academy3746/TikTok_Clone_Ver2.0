import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok/features/main_navigation/widgets/post_video_button.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Debug
  final screens = [
    const Center(
      child: Text(
        "HOME",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        "DISCOVER",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        "UPLOAD",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        "INBOX",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        "PROFILE",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        // Render Camera Widget later
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              "Record Video",
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: screens[_selectedIndex],
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "HOME",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: "DISCOVER",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onTapVideoButtonTap,
                child: const PostVideoButton(),
              ),
              Gaps.h24,
              NavTab(
                text: "INBOX",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: "PROFILE",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
