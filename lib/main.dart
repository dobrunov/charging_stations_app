import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/favorite_storage_service.dart';
import 'data/repositories/stations_repository.dart';
import 'features/station_list/station_list_screen.dart';
import 'features/station_list/station_list_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stationsRepository = StationsRepository();
  final favoriteStorageService = FavoriteStorageService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StationListCubit(stationsRepository, favoriteStorageService),
        ),
      ],
      child: MyApp(
        stationsRepository: stationsRepository,
        storageService: favoriteStorageService,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final StationsRepository stationsRepository;
  final FavoriteStorageService storageService;

  const MyApp({super.key, required this.stationsRepository, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EV Charging Stations',
      home: BlocProvider(
        create: (context) => StationListCubit(stationsRepository, storageService)..loadStations(),
        child: StationListScreen(),
      ),
    );
  }
}