import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/models/vol.dart';
import 'package:flutter/services.dart';


class api{

  Future<List<Vol>> getVols() async{
    final response = await http.get(Uri.parse('http://localhost:3000/vols'));

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


  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}