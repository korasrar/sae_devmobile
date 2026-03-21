import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/UI/myVols.dart';
import 'package:mobile/UI/theme.dart';
import 'package:mobile/UI/home.dart';
import 'package:provider/provider.dart';
import 'package:mobile/UI/settings.dart';

import 'package:mobile/viewModel/settingViewModel.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';

class flyApp extends StatelessWidget{
  const flyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) {
                SettingViewModel svm = SettingViewModel();
                return svm;
              }
          ),
          ChangeNotifierProvider(
            create: (_) {
              MyVolsViewModel mvvm = MyVolsViewModel();
              return mvvm;
          }
          )
        ],
        child: Consumer<SettingViewModel>(
            builder: (context, SettingViewModel notifier, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: notifier.isDark ? MyTheme.dark() : MyTheme.light(),
                title: 'Vols',
                home: const HomePage(title: 'Vols'),

              );
            }
        )
    );
  }
}

class HomePage extends StatefulWidget{
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int _seledtedIndex = 0;

  List<Widget> pages = [
    home(),
    myVols(),
    EcranSettings()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _seledtedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pages[_seledtedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket),
              label: "Vols"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Mes Vols"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
          ),
        ],
        currentIndex: _seledtedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}