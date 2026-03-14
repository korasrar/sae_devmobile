import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget{
  home({super.key})

  //faire les vols ici
  //late List<Task> tasks; //= Task.generateTask(50);
  //String tags = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text('hello world !')
      ),
    );
  }
}