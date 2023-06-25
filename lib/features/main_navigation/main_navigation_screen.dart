import 'package:flutter/cupertino.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  //int _selectedIndex = 0;

  // Debug
  final screens = [
    const Center(
      child: Text("Fuck U!"),
    ),
    const Center(
      child: Text("Fuck U too!"),
    ),
    const Center(
      child: Text("Fuck U very much!"),
    ),
    const Center(
      child: Text("Fuck me harder!"),
    ),
    const Center(
      child: Text("Cum inside my pussy!"),
    ),
  ];

  /*
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.house,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
            ),
            label: "Search",
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) => screens[index],
    );
  }
}
