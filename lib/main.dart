import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'features/station_list/station_list_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox<List<String>>('favoritesBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EV Charging Stations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StationListScreen(),
    );
  }
}
