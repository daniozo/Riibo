import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:riibo/provider/connectivity_provider.dart';
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
  bool _isConnected = false;

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Root();
        },
        routes: <RouteBase>[
          // GoRoute(
          //   path: 'home',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const HomeScreen();
          //   },
          // ),
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
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print(connectivityResult);

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _isConnected = true;
      });
    } else {
      setState(() {
        _isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: CupertinoApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
