import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/models/vol.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';
import 'detail.dart';

class myVols extends StatelessWidget {
  const myVols({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyVolsViewModel>();
    final vols = viewModel.filteredVols;

    return Column(
      children: [
        const SizedBox(height: 10),
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            viewModel.toggleFilter(index);
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: Colors.blue[700],
          selectedColor: Colors.white,
          fillColor: Colors.blue[200],
          color: Colors.blue[400],
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 100.0,
          ),
          isSelected: viewModel.selectedFilters,
          children: const <Widget>[
            Text('Perso'),
            Text('Pro'),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: vols.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: vols[index].isPro ? Colors.purple : Colors.green,
                elevation: 7,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    child: Text(vols[index].num_vol.toString()),
                  ),
                  title: Text(vols[index].date_depart),
                  subtitle: Text(vols[index].date_arrive),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () async {
                      context.read<MyVolsViewModel>().deleteVol(vols[index]);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
