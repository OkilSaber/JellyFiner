import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jellyfiner/screens/home_tab.dart';
import 'package:jellyfiner/screens/server_input.dart';
import 'package:jellyfiner/screens/settings_tab.dart';
import 'package:jellyfiner/types/server_config.dart';

class MainScreen extends StatefulWidget {
  final ServerConfig config;

  const MainScreen({super.key, required this.config});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _widgetOptions = <Widget>[
      HomeTab(config: widget.config),
      const Center(child: Text('Search')),
      SettingsTab(
        onClear: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ServerInput(),
            ),
          );
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        onTap: (value) => _onItemTapped(value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              child: _widgetOptions.elementAt(_selectedIndex),
            );
          },
        );
      },
    );
  }
}
