import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/API/endpoints.dart';
import 'package:mobile/models/vol.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
        case 0:
          results = await myApi.getDestinationsFromCity(city);
          break;
        case 1:
          results = await myApi.getDestinations1Escale(city);
          break;
        case 2:
          results = await myApi.getDestinations2Escales(city);
          break;
        case 3:
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
          padding: const EdgeInsets.all(16.0),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                hintText: "Entrez une ville de départ",
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3)),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () => controller.openView(),
                onChanged: (_) => controller.openView(),
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              final List<String> cities = ['Paris', 'Lyon', 'Marseille', 'Toulouse', 'Nice'];
              
              return cities.map((city) => ListTile(
                title: Text(city),
                onTap: () {
                  setState(() {
                    controller.closeView(city);
                  });
                  _searchDestinations(city, 3);
                },
              )).toList();
            },
          ),
        ),
        if (_selectedCity.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text("Directes"), 
                    onSelected: (_) => _searchDestinations(_selectedCity, 0),
                    selected: false,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("1 Escale"), 
                    onSelected: (_) => _searchDestinations(_selectedCity, 1),
                    selected: false,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("2 Escales"), 
                    onSelected: (_) => _searchDestinations(_selectedCity, 2),
                    selected: false,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("Toutes"), 
                    onSelected: (_) => _searchDestinations(_selectedCity, 3),
                    selected: true,
                  ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Destinations depuis $_selectedCity :", 
                        style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Expanded(
                      child: _destinations.isEmpty 
                        ? const Center(child: Text("Aucune destination trouvée"))
                        : ListView.builder(
                            itemCount: _destinations.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.location_on, color: Colors.blue),
                                title: Text(_destinations[index]),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              );
                            },
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => setState(() => _selectedCity = ""), 
                        label: const Text("Retour à la liste complète")
                      ),
                    )
                  ],
                ),
          ),
      ],
    );
  }

  Widget _buildVolCard(BuildContext context, Vol vol) {
    String formattedDate = vol.date_depart;
    try {
      final DateTime dt = DateTime.parse(vol.date_depart);
      formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dt);
    } catch (e) {}

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/detail', extra: vol),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    vol.num_vol.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vol #${vol.num_vol}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.flight_takeoff, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(formattedDate, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: Theme.of(context).colorScheme.primary),
                onPressed: () => _showAddDialog(context, vol),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context, Vol vol) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Ajouter à mes vols"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person, color: Colors.green),
                title: const Text("Vol Personnel"),
                onTap: () {
                  vol.isPro = false;
                  context.read<MyVolsViewModel>().addVol(vol);
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vol ajouté aux favoris')));
                },
              ),
              ListTile(
                leading: const Icon(Icons.work, color: Colors.purple),
                title: const Text("Vol Professionnel"),
                onTap: () {
                  vol.isPro = true;
                  context.read<MyVolsViewModel>().addVol(vol);
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vol ajouté aux favoris')));
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => context.pop(), child: const Text("Annuler"))
          ],
      ),
    );
  }
}
