import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/charging_station_model.dart';
import '../../services/shared_preferences_service.dart';
import '../../services/charging_station_service.dart';
import '../../features/station_detail/station_detail_screen.dart';

class StationListScreen extends StatefulWidget {
  const StationListScreen({super.key});

  @override
  StationListScreenState createState() => StationListScreenState();
}

class StationListScreenState extends State<StationListScreen> {
  late Future<List<ChargingStation>> _stationsFuture;
  late List<ChargingStation> _stations;
  late SharedPreferencesService _sharedPreferencesService;

  @override
  void initState() {
    super.initState();
    _stationsFuture = ChargingStationService().fetchChargingStations();
    _sharedPreferencesService = SharedPreferencesService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EV Charging Stations"),
      ),
      body: FutureBuilder<List<ChargingStation>>(
        future: _stationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          _stations = snapshot.data!;
          return ListView.builder(
            itemCount: _stations.length,
            itemBuilder: (context, index) {
              final station = _stations[index];
              return ListTile(
                title: Text(station.name, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(station.address, style: TextStyle(fontSize: 12)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(station.pricePerKwh,style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("UAH",style: TextStyle(fontSize: 10)),
                        Text("kWh",style: TextStyle(fontSize: 10)),
                      ],
                    ),


                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        station.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: station.isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          station.isFavorite = !station.isFavorite;
                        });
                        _sharedPreferencesService.saveFavoriteStations(_stations);
                      },
                    ),
                  ],
                ),
                leading: _getConnectorIcon(station.connectorType),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StationDetailScreen(station: station),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _getConnectorIcon(String connectorType) {
    switch (connectorType) {
      case 'Type2':
        return Image.asset(
          'assets/images/type2_plug.png',
          width: 38,
          height: 38,
          color: Colors.blue[900],
        );
      case 'CCS2':
        return Image.asset(
          'assets/images/ccs2_plug.png',
          width: 40,
          height: 40,
          color: Colors.blue[900],
        );
      case 'TeslaS':
        return SvgPicture.asset(
          'assets/images/tesla_s_plug.svg',
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(Colors.blue.shade900, BlendMode.srcIn),
        );
      default:
        return Icon(
          Icons.battery_charging_full,
          size: 40,
          color: Colors.blue[900],
        );
    }
  }
}
