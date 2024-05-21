import 'package:flutter/cupertino.dart';
import 'package:riibo/screens/discover/discover_screen.dart';
import 'package:riibo/screens/favorites/favorites_screen.dart';
import 'package:riibo/screens/home/home_screen.dart';

import 'delivery/delivery_screen.dart';

class Root extends StatefulWidget {
  const Root({
    super.key,
  });

  @override
  RootState createState() => RootState();
}

class RootState extends State<Root> {
  late CupertinoTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = CupertinoTabController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = CupertinoColors.systemOrange;

    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              CupertinoIcons.house,
              size: 24,
            ),
            activeIcon: Icon(
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
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return HomeScreen(tabController: _tabController);
              case 1:
                return const DiscoverScreen();
              case 2:
                return const FavoriteScreen();
              case 3:
                return const DeliveryScreen();
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}
