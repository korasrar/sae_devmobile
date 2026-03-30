import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/models/vol.dart';
import 'package:flutter/services.dart';


class api{
  final String baseUrl = 'http://localhost:5000';

  Future<List<Vol>> getVols() async{
    final response = await http.get(Uri.parse('$baseUrl/api/vols'));

    if(response.statusCode == 200){
      final List<dynamic> json = jsonDecode(response.body);
      final vols = <Vol>[];
      for(var vol in json){
        vols.add(Vol.fromJson(vol));
      }
      return vols;
    }else{
      throw Exception("Failed to fetch vols");
    }
  }

  Future<String> getAeroportName(int idAeroport) async {
    final response = await http.get(Uri.parse('$baseUrl/api/aeroports/$idAeroport'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['nom_aeroport'];
    } else {
      throw Exception("Failed to fetch aeroport name for id $idAeroport");
    }
  }

  Future<List<String>> getDestinationsFromCity(String ville) async {
    final response = await http.get(Uri.parse('$baseUrl/api/villes/$ville/destinations'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return List<String>.from(data['destinations']);
    } else {
      throw Exception("Failed to fetch destinations from $ville");
    }
  }

  Future<List<String>> getDestinations1Escale(String ville) async {
    final response = await http.get(Uri.parse('$baseUrl/api/destinations/$ville/1-escale'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return List<String>.from(data['destinations']);
    } else {
      throw Exception("Failed to fetch 1-stop destinations from $ville");
    }
  }

  Future<List<String>> getDestinations2Escales(String ville) async {
    final response = await http.get(Uri.parse('$baseUrl/api/destinations/$ville/2-escales'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return List<String>.from(data['destinations']);
    } else {
      throw Exception("Failed to fetch 2-stops destinations from $ville");
    }
  }

  Future<List<String>> getDestinationsRecursive(String ville) async {
    final response = await http.get(Uri.parse('$baseUrl/api/destinations/$ville/toutes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['ville'] as String).toList();
    } else {
      throw Exception("Failed to fetch all recursive destinations from $ville");
    }
  }
}