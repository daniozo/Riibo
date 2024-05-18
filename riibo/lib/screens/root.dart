import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riibo/screens/discover/discover_screen.dart';
import 'package:riibo/screens/favorites/favorites_screen.dart';
import 'package:riibo/screens/home/home_screen.dart';

class Root extends StatefulWidget {
  // final Widget child;

  const Root({
    super.key,
    // required this.child,
  });

  @override
  RootState createState() => RootState();
}

class RootState extends State<Root> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Get the CupertinoTabScaffold's controller

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Color color = Color(0xFFFECE2F);
    Color color =  CupertinoColors.systemOrange;


    Widget currentScreen = const HomeScreen();

    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }

    return CupertinoTabScaffold(
      key: navigatorKey,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.house,
              size: 24,
            ),
            activeIcon:  Icon(
              CupertinoIcons.house_fill,
              size: 24,
              color: color,
            ),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.compass,
              size: 24,
            ),
            activeIcon: Icon(
              CupertinoIcons.compass_fill,
              size: 24,
              color: color,
            ),
            label: "Découvrir",
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.heart,
              size: 24,
            ),
            activeIcon: Icon(
              CupertinoIcons.heart_fill,
              size: 24,
              color: color,
            ),
            label: "Favoris",
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.cube_box,
              size: 24,
            ),
            activeIcon: Icon(
              CupertinoIcons.cube_box_fill,
              size: 24,
              color: color,
            ),
            label: "Livraison",
          ),
        ],
        activeColor: color,
        backgroundColor: CupertinoColors.white.withOpacity(0.34),
        // border: Border.all(),
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return const HomeScreen();
              case 1:
                return const DiscoverScreen();
              case 2:
                return const FavoriteScreen();
              default:
                return const HomeScreen();
            }
          },
        );
      },
    );
  }
}
