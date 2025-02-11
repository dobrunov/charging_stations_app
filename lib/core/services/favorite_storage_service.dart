import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStorageService {
  static const String favoriteStationsKey = 'favorite_stations';

  Future<void> saveFavoriteStations(List<String> favoriteStations) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favoriteStationsKey, favoriteStations.map((e) => e.toString()).toList());
  }

  Future<List<String>> getFavoriteStations() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteStations = prefs.getStringList(favoriteStationsKey) ?? [];
    return favoriteStations.map((e) => e).toList();
  }
}

