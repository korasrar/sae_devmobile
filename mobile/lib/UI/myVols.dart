import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/models/vol.dart';
import 'package:mobile/viewModel/myVolsViewModel.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

  String _formatDate(String dateStr) {
    try {
      final DateTime dt = DateTime.parse(dateStr);
      return DateFormat('dd/MM HH:mm').format(dt);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyVolsViewModel>();
    final vols = viewModel.filteredVols;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher un vol (n°, date...)',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('Perso'), icon: Icon(Icons.person_outline)),
              ButtonSegment(value: 1, label: Text('Pro'), icon: Icon(Icons.work_outline)),
            ],
            selected: viewModel.selectedFilters[0] && viewModel.selectedFilters[1]
                ? {0, 1}
                : viewModel.selectedFilters[0]
                    ? {0}
                    : viewModel.selectedFilters[1]
                        ? {1}
                        : {},
            onSelectionChanged: (Set<int> newSelection) {
              // Implementation might vary based on ViewModel logic
              // For now, let's keep it simple and trigger the existing toggle logic if possible
              // or just match the view model's expectations.
              if (newSelection.contains(0) != viewModel.selectedFilters[0]) viewModel.toggleFilter(0);
              if (newSelection.contains(1) != viewModel.selectedFilters[1]) viewModel.toggleFilter(1);
            },
            multiSelectionEnabled: true,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: vols.isEmpty 
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.airplane_ticket_outlined, size: 64, color: Colors.grey.withOpacity(0.5)),
                    const SizedBox(height: 16),
                    Text("Aucun vol trouvé", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey)),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: vols.length,
                itemBuilder: (BuildContext context, int index) {
                  final vol = vols[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      onTap: () => context.push('/detail', extra: vol),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: vol.isPro 
                              ? Colors.purple.withOpacity(0.1) 
                              : Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          vol.isPro ? Icons.work : Icons.person,
                          color: vol.isPro ? Colors.purple : Colors.green,
                        ),
                      ),
                      title: Text(
                        "Vol #${vol.num_vol}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${_formatDate(vol.date_depart)} → ${_formatDate(vol.date_arrive)}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => viewModel.deleteVol(vol),
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
