import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riibo/screens/discover/discover_screen.dart';
import 'package:riibo/screens/favorites/favorites_screen.dart';
import 'package:riibo/screens/home/home_screen.dart';
import 'package:riibo/screens/root.dart';

class Riibo extends StatefulWidget {
  const Riibo({super.key});

  @override
  State<Riibo> createState() => _RiiboState();
}

class _RiiboState extends State<Riibo> {
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Root();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            path: 'discover',
            builder: (BuildContext context, GoRouterState state) {
              return const DiscoverScreen();
            },
          ),
          GoRoute(
            path: 'favorites',
            builder: (BuildContext context, GoRouterState state) {
              return const FavoriteScreen();
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
