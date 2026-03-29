import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/API/endpoints.dart';
import 'package:mobile/UI/detail.dart';
import 'package:mobile/models/vol.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final api myApi = api();
  final SearchController controller = SearchController();
  String _selectedCity = "";
  List<String> _destinations = [];
  bool _isLoadingDestinations = false;

  Future<void> _searchDestinations(String city, int type) async {
    setState(() {
      _isLoadingDestinations = true;
      _selectedCity = city;
    });

    try {
      List<String> results;
      switch (type) {
        case 0: // Direct
          results = await myApi.getDestinationsFromCity(city);
          break;
        case 1: // 1 Escale
          results = await myApi.getDestinations1Escale(city);
          break;
        case 2: // 2 Escales
          results = await myApi.getDestinations2Escales(city);
          break;
        case 3: // Toutes
          results = await myApi.getDestinationsRecursive(city);
          break;
        default:
          results = [];
      }
      setState(() {
        _destinations = results;
        _isLoadingDestinations = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingDestinations = false;
        _destinations = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                hintText: "Entrez une ville de départ",
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              // Villes statiques pour l'exemple ou à récupérer via une API de villes si disponible
              final List<String> cities = ['Paris', 'Lyon', 'Marseille', 'Toulouse', 'Nice'];
              
              return cities.map((city) => ListTile(
                title: Text(city),
                onTap: () {
                  setState(() {
                    controller.closeView(city);
                  });
                  _searchDestinations(city, 3); // Par défaut toutes par exemple
                },
              )).toList();
            },
          ),
        ),
        if (_selectedCity.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Escales: "),
                  ActionChip(label: const Text("Directes"), onPressed: () => _searchDestinations(_selectedCity, 0)),
                  const SizedBox(width: 5),
                  ActionChip(label: const Text("1 Escale"), onPressed: () => _searchDestinations(_selectedCity, 1)),
                  const SizedBox(width: 5),
                  ActionChip(label: const Text("2 Escales"), onPressed: () => _searchDestinations(_selectedCity, 2)),
                  const SizedBox(width: 5),
                  ActionChip(label: const Text("Toutes"), onPressed: () => _searchDestinations(_selectedCity, 3)),
                ],
              ),
            ),
          ),
        
        _selectedCity.isEmpty 
        ? Expanded(
            child: FutureBuilder(
                future: myApi.getVols(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext context, index) {
                        return _buildVolCard(context, snapshot.data![index]);
                      },
                    );
                  }
                  return const Center(child: Text("Aucune donnée trouvée"));
                }),
          )
        : Expanded(
            child: _isLoadingDestinations 
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Destinations depuis $_selectedCity :", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: _destinations.isEmpty 
                        ? const Center(child: Text("Aucune destination trouvée"))
                        : ListView.builder(
                            itemCount: _destinations.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.location_city),
                                title: Text(_destinations[index]),
                              );
                            },
                          ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _selectedCity = ""), 
                      child: const Text("Retour à la liste complète")
                    )
                  ],
                ),
          ),
      ],
    );
  }

  Widget _buildVolCard(BuildContext context, Vol vol) {
    return Card(
      color: Colors.white,
      elevation: 7,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Text(vol.num_vol.toString()),
        ),
        title: Text(vol.date_depart),
        subtitle: Text(vol.date_arrive.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.blue),
          onPressed: () => _showAddDialog(context, vol),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => Detail(vol: vol),
            ),
          );
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context, Vol vol) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
          content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40,
                  top: -40,
                  child: InkResponse(
                    onTap: () => Navigator.of(context).pop(),
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      child: const Text("Vol Personnel"),
                      onPressed: () {
                        vol.isPro = false;
                        context.read<MyVolsViewModel>().addVol(vol);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vol ajouté aux favoris')));
                      },
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      child: const Text("Vol Professionnel"),
                      onPressed: () {
                        vol.isPro = true;
                        context.read<MyVolsViewModel>().addVol(vol);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vol ajouté aux favoris')));
                      },
                    )
                  ],
                )
              ])),
    );
  }
}
