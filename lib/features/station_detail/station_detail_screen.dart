import 'package:flutter/material.dart';
import '../../models/charging_station_model.dart';

class StationDetailScreen extends StatelessWidget {
  final ChargingStation station;

  const StationDetailScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${station.name}", style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Text("Address: ${station.address}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Status: ${station.status}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
