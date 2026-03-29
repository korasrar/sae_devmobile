import 'package:flutter/material.dart';
import 'package:mobile/UI/myVols.dart';
import 'package:mobile/UI/theme.dart';
import 'package:mobile/UI/home.dart';
import 'package:mobile/UI/aeroport_map.dart';
import 'package:mobile/UI/detail.dart';
import 'package:provider/provider.dart';
import 'package:mobile/UI/settings.dart';
import 'package:mobile/services/databaseServices.dart';
import 'package:mobile/viewModel/settingViewModel.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/models/vol.dart';

class flyApp extends StatelessWidget {
  final Database db;
  late final GoRouter _router;

  flyApp({super.key, required this.db}) {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return HomePage(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const home(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/my-vols',
                  builder: (context, state) => const myVols(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/map',
                  builder: (context, state) => const aeroports_map(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (context, state) => const EcranSettings(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) {
            final vol = state.extra as Vol;
            return Detail(vol: vol);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingViewModel()),
        ChangeNotifierProvider(
          create: (_) => MyVolsViewModel(database: databaseServices(db: db)),
        )
      ],
      child: Consumer<SettingViewModel>(
        builder: (context, notifier, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: notifier.isDark ? MyTheme.dark() : MyTheme.light(),
            title: 'Vols',
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vols'),
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: "Vols",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Mes Vols",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
