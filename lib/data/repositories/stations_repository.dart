import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/charging_station_model.dart';

class StationsRepository {
  Future<List<ChargingStation>> fetchChargingStations() async {
    final String response = await rootBundle.loadString('assets/jsons/charging_stations.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => ChargingStation.fromJson(json)).toList();
  }
}