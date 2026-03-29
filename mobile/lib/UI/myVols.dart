import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/models/vol.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';
import 'detail.dart';

class myVols extends StatefulWidget {
  const myVols({super.key});

  @override
  State<myVols> createState() => _myVolsState();
}

class _myVolsState extends State<myVols> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyVolsViewModel>();
    final vols = viewModel.filteredVols;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher un vol (n°, date...)',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        viewModel.setSearchQuery("");
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              viewModel.setSearchQuery(value);
            },
          ),
        ),
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
          child: vols.isEmpty 
            ? const Center(child: Text("Aucun vol ne correspond à vos critères"))
            : ListView.builder(
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
