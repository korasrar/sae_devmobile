import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/vol.dart';

class Detail extends StatelessWidget{
  final Vol vol;

  const Detail({super.key, required this.vol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail du vol n°${vol.num_vol}'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.key),
                title: const Text('terminal de départ'),
                subtitle: Text('${vol.terminal_depart}'),
              ),
            ),
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.description),
                title: const Text("terminal d'arrivée"),
                subtitle: Text('${vol.terminal_arrive}'),
              ),
            ),
          ],
        ),
      ),
    );
  }


}