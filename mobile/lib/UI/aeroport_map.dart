import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/API/endpoints.dart';
import 'package:mobile/models/vol.dart';

class aeroports_map extends StatefulWidget {
  const aeroports_map({super.key});

  @override
  State<aeroports_map> createState() => _aeroports_mapState();
}

class _aeroports_mapState extends State<aeroports_map> {
  late MapController controller;
  final api myApi = api();
  final Set<int> _processedAirports = {};
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initPosition: GeoPoint(
        latitude: 46.2276,
        longitude: 2.2137,
      ),
    );
  }

  Future<void> _loadAirportsFromVols() async {
    if (_loading) return;
    setState(() => _loading = true);

    try {
      List<Vol> vols = await myApi.getVols();
      
      Set<int> airportIds = {};
      for (var vol in vols) {
        airportIds.add(vol.id_aeroport_depart);
        airportIds.add(vol.id_aeroport_arrive);
      }

      for (int id in airportIds) {
        if (_processedAirports.contains(id)) continue;

        try {
          String name = await myApi.getAeroportName(id);
          
          final geoUrl = Uri.parse('https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(name)}&format=json&limit=1');
          final response = await http.get(geoUrl, headers: {'User-Agent': 'MobileAppProject/1.0'});

          if (response.statusCode == 200) {
            List data = jsonDecode(response.body);
            if (data.isNotEmpty) {
              double lat = double.parse(data[0]['lat']);
              double lon = double.parse(data[0]['lon']);
              GeoPoint point = GeoPoint(latitude: lat, longitude: lon);

              await controller.addMarker(
                point,
                markerIcon: const MarkerIcon(
                  icon: Icon(
                    Icons.local_airport,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              );
              _processedAirports.add(id);
            }
          }
          await Future.delayed(const Duration(milliseconds: 1000));
        } catch (e) {
          debugPrint("Erreur pour l'aéroport ID $id : $e");
        }
      }
    } catch (e) {
      debugPrint("Erreur globale : $e");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte des Aéroports'),
        actions: [
          if (_loading)
            const Center(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
            ))
          else
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadAirportsFromVols,
            )
        ],
      ),
      body: OSMFlutter(
        controller: controller,
        onMapIsReady: (isReady) {
          if (isReady) {
            _loadAirportsFromVols();
          }
        },
        osmOption: const OSMOption(
          zoomOption: ZoomOption(
            initZoom: 5,
            minZoomLevel: 3,
            maxZoomLevel: 19,
          ),
          userTrackingOption: UserTrackingOption(
            enableTracking: false,
            unFollowUser: false,
          ),
          isPicker: false,
        ),
      ),
    );
  }
}
