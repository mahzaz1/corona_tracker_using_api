import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Model/WorldStatsModel.dart';
import 'AppsUrl.dart';

class StatsServices{


  Future<WorldStatsModel> fetchWorldStatsRecord () async{
    final response = await http.get(Uri.parse(AppUrl.worldApi));
    var data = jsonDecode(response.body);

    if(response.statusCode == 200){
      return WorldStatsModel.fromJson(data);
    }else{
      throw Exception('error');
    }
  }

  Future<List<dynamic>> fetchCountriesStatsRecord () async{
    final response = await http.get(Uri.parse(AppUrl.countriesApi));
    var data;

    if(response.statusCode == 200){
      data = jsonDecode(response.body);

      return data;
    }else{
      throw Exception('error');
    }
  }
}