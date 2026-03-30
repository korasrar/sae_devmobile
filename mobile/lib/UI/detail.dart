import 'package:flutter/material.dart';
import 'package:mobile/models/vol.dart';
import 'package:intl/intl.dart';

class Detail extends StatelessWidget {
  final Vol vol;

  const Detail({super.key, required this.vol});

  String _formatDate(String dateStr) {
    try {
      final DateTime dt = DateTime.parse(dateStr);
      return DateFormat('dd MMMM yyyy à HH:mm', 'fr_FR').format(dt);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du vol #${vol.num_vol}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoCard(
              context,
              title: "Informations Générales",
              icon: Icons.info_outline,
              items: [
                _InfoItem(label: "Numéro de vol", value: vol.num_vol.toString()),
                _InfoItem(label: "Compagnie ID", value: vol.id_compagnie.toString()),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              context,
              title: "Départ",
              icon: Icons.flight_takeoff,
              color: Colors.blue,
              items: [
                _InfoItem(label: "Aéroport ID", value: vol.id_aeroport_depart.toString()),
                _InfoItem(label: "Date & Heure", value: _formatDate(vol.date_depart)),
                _InfoItem(label: "Terminal", value: vol.terminal_depart.toString()),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              context,
              title: "Arrivée",
              icon: Icons.flight_land,
              color: Colors.green,
              items: [
                _InfoItem(label: "Aéroport ID", value: vol.id_aeroport_arrive.toString()),
                _InfoItem(label: "Date & Heure", value: _formatDate(vol.date_arrive)),
                _InfoItem(label: "Terminal", value: vol.terminal_arrive.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required String title,
      required IconData icon,
      required List<_InfoItem> items,
      Color? color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color ?? Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                      Text(item.value, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  _InfoItem({required this.label, required this.value});
}
