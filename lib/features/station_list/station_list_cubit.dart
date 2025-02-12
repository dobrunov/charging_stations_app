import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/favorite_storage_service.dart';
import '../../data/models/charging_station_model.dart';
import '../../data/repositories/stations_repository.dart';

class StationListCubit extends Cubit<List<ChargingStation>> {
  final StationsRepository stationsRepository;
  final FavoriteStorageService favoriteStorageService;
  bool showFavoritesOnly = false;

  StationListCubit(this.stationsRepository, this.favoriteStorageService) : super([]);

  Future<void> loadStations() async {
    final chargingStations = await stationsRepository.fetchChargingStations();
    final favoriteStationsIds = await favoriteStorageService.getFavoriteStations();

    for (var station in chargingStations) {
      station.isFavorite = favoriteStationsIds.contains(station.id);
    }
    emit(chargingStations);
  }

  void toggleFavorite(String id) async {
    final updatedStations = state.map((station) {
      if (station.id == id) {
        return ChargingStation(
          id: station.id,
          name: station.name,
          address: station.address,
          isFavorite: !station.isFavorite,
          status: station.status,
          connectorType: station.connectorType,
          pricePerKwh: station.pricePerKwh,
        );
      }
      return station;
    }).toList();

    emit(updatedStations);

    final favoriteStationsIds = updatedStations.where((station) => station.isFavorite).map((station) => station.id).toList();
    await favoriteStorageService.saveFavoriteStations(favoriteStationsIds);
  }

  void toggleFavoritesFilter() {
    showFavoritesOnly = !showFavoritesOnly;
    if (showFavoritesOnly) {
      emit(state.where((station) => station.isFavorite).toList());
    } else {
      loadStations();
    }
  }
}
