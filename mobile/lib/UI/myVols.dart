import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/models/vol.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';
import 'detail.dart';

class myVols extends StatelessWidget{
  myVols({super.key});

  late List<Vol> vols; //= Task.generateTask(50);

  @override
  Widget build(BuildContext context) {
    vols = context.watch<MyVolsViewModel>().liste;
    return ListView.builder(
        itemCount: vols.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            color: Colors.white,
            elevation: 7,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child:  Text(vols[index].num_vol.toString()
                ),
              ),
              title: Text(vols[index].date_depart),
              subtitle: Text(vols[index].date_arrive),
            ),
          );
        }
    );
  }


}