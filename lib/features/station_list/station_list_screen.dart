import 'dart:io';

import 'package:charging_stations_app/features/station_list/widgets/animated_favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/util_methods.dart';
import '../../data/models/charging_station_model.dart';
import '../../features/station_detail/station_detail_screen.dart';
import '../../features/station_list/widgets/price_widget.dart';
import '../../features/station_list/widgets/status_dot_widget.dart';
import 'station_list_cubit.dart';

class StationListScreen extends StatefulWidget {
  const StationListScreen({super.key});

  @override
  State<StationListScreen> createState() => _StationListScreenState();
}

class _StationListScreenState extends State<StationListScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stationsCubit = context.read<StationListCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Stations list'),
        actions: [
          AnimatedFavoriteButton(
            onPressed: () {
              stationsCubit.toggleFavoritesFilter();
            },
          ),
        ],
      ),
      body: BlocBuilder<StationListCubit, List<ChargingStation>>(
        builder: (context, stations) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: stations.length,
            itemBuilder: (context, index) {
              final station = stations[index];

              return FadeTransition(
                opacity: _fadeController,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: _buildListTile(station, stationsCubit),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildListTile(ChargingStation station, StationListCubit cubit) {
    return ListTile(
      leading: UtilMethods.getConnectorIcon(station.connectorType),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(station.name, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          StatusDotWidget(status: station.status, diameter: 8),
        ],
      ),
      subtitle: Text(station.address, style: TextStyle(fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PriceWidget(station: station),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.elasticOut);
              return ScaleTransition(scale: curvedAnimation, child: child);
            },
            child: IconButton(
              key: ValueKey(station.isFavorite),
              icon: Icon(
                station.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: station.isFavorite ? Color(0xFF3E9C4B) : null,
              ),
              onPressed: () {
                cubit.toggleFavorite(station.id);
              },
            ),
          ),
        ],
      ),
      onTap: () async {
        final updatedId = await Navigator.push(
          context,
          Platform.isIOS
              ? CupertinoPageRoute(
                  builder: (context) => StationDetailScreen(station: station),
                )
              : PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: StationDetailScreen(station: station),
                      ),
                    );
                  },
                ),
        );
        if (updatedId != null) {
          cubit.toggleFavorite(updatedId);
        }
      },
    );
  }
}
