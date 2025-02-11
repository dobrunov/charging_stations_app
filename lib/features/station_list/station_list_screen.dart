
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

class _StationListScreenState extends State<StationListScreen> {
  @override
  Widget build(BuildContext context) {
    final stationsCubit = context.read<StationListCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Stations list'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                stationsCubit.toggleFavorites();
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<StationListCubit, List<ChargingStation>>(
        builder: (context, stations) {
          return ListView.builder(
            itemCount: stations.length,
            itemBuilder: (context, index) {
              final station = stations[index];
              return ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(station.name, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      StatusDotWidget(status: station.status, diameter: 8)
                    ],
                  ),
                  subtitle: Text(station.address, style: TextStyle(fontSize: 12)),
                  trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      PriceWidget(station: station),
                      IconButton(
                        icon: Icon(
                        station.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: station.isFavorite ? Color(0xFF3E9C4B) : null,

                        ),
                      onPressed: () {
                          stationsCubit.toggleFavorite(station.id);
                        },
                      ),
                  ],
                ),
                leading: UtilMethods.getConnectorIcon(station.connectorType),
                  onTap: () async {
                    final stationsCubit = context.read<StationListCubit>();

                    final updatedId = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StationDetailScreen(station: station),
                      ),
                    );

                    if (updatedId != null) {
                      stationsCubit.toggleFavorite(updatedId);
                    }
                  });
            },
          );
        },
      ),
    );
  }
}


