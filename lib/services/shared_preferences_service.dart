import '../models/charging_station_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SharedPreferencesService {
  static const String _boxName = 'favoritesBox';
  static const String _keyFavorites = 'favorites';

  Future<void> saveFavoriteStations(List<ChargingStation> stations) async {
    final box = await Hive.openBox<List<String>>(_boxName);
    List<String> favorites = stations
        .where((station) => station.isFavorite)
        .map((station) => station.id)
        .toList();
    await box.put(_keyFavorites, favorites);
  }

  Future<List<String>> loadFavoriteStations() async {
    final box = await Hive.openBox<List<String>>(_boxName);
    return box.get(_keyFavorites, defaultValue: []) ?? [];
  }
}
