import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/UI/theme.dart';
import 'package:mobile/UI/home.dart';
import 'package:provider/provider.dart';
import 'package:mobile/viewModel/settingViewModel.dart';

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
              label: "Home"
          )
        ],
      ),
    );
  }
}