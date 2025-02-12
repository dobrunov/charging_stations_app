import 'package:flutter/material.dart';

import 'core/config/app_router.dart';
import 'core/services/favorite_storage_service.dart';
import 'data/repositories/stations_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stationsRepository = StationsRepository();
  final favoriteStorageService = FavoriteStorageService();

  runApp(
    MyApp(
      stationsRepository: stationsRepository,
      favoriteStorageService: favoriteStorageService,
    ),
  );
}

class MyApp extends StatelessWidget {
  final StationsRepository stationsRepository;
  final FavoriteStorageService favoriteStorageService;

  const MyApp({
    super.key,
    required this.stationsRepository,
    required this.favoriteStorageService,
  });

  @override
  Widget build(BuildContext context) {
    final router = createRouter(
      stationsRepository: stationsRepository,
      favoriteStorageService: favoriteStorageService,
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'EV Charging Stations',
      routerConfig: router,
    );
  }
}
