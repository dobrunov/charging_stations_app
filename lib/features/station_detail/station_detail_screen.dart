import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/charging_station_model.dart';
import '../station_list/station_list_cubit.dart';

class StationDetailScreen extends StatefulWidget {
  final ChargingStation station;

  const StationDetailScreen({super.key, required this.station});

  @override
  State<StationDetailScreen> createState() => _StationDetailScreenState();
}

class _StationDetailScreenState extends State<StationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final stationsCubit = context.read<StationListCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.station.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(widget.station.address, style: TextStyle(fontSize: 18)),
                    ),
                    Text(widget.station.status, style: TextStyle(fontSize: 16, color: _getColorFor(widget.station.status))),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    widget.station.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: widget.station.isFavorite ? Color(0xFF2C8639) : null,
                  ),
                  onPressed: () {
                    stationsCubit.toggleFavorite(widget.station.id);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Price per kWh - ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
                Text("${widget.station.pricePerKwh} UAH", style: TextStyle(fontSize: 16, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFor(String status) {
    switch (status) {
      case 'Available':
        return Colors.green;
      case 'Occupied':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
