import 'package:flutter/material.dart';

import '../../../data/models/charging_station_model.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.station,
  });

  final ChargingStation station;

  @override
  Widget build(BuildContext context) {
    return Row(
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
      ],
    );
  }
}