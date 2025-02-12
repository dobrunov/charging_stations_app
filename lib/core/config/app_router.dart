import 'dart:io';

import 'package:charging_stations_app/core/services/favorite_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/charging_station_model.dart';
import '../../data/repositories/stations_repository.dart';
import '../../features/station_detail/station_detail_screen.dart';
import '../../features/station_list/station_list_cubit.dart';
import '../../features/station_list/station_list_screen.dart';

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
  );
}

GoRouter createRouter({
  required StationsRepository stationsRepository,
  required FavoriteStorageService favoriteStorageService,
}) {
  final stationListCubit = StationListCubit(
    stationsRepository,
    favoriteStorageService,
  )..loadStations();

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider.value(
          value: stationListCubit,
          child: const StationListScreen(),
        ),
      ),
      GoRoute(
        path: '/station/:id',
        pageBuilder: (context, state) {
          final station = state.extra as ChargingStation;
          final child = BlocProvider.value(
            value: stationListCubit,
            child: StationDetailScreen(station: station),
          );

          if (Platform.isIOS) {
            return CupertinoPage(child: child);
          }

          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: child,
          );
        },
      ),
    ],
  );
}
