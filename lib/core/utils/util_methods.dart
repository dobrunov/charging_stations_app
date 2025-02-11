import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class UtilMethods{

  static Widget getConnectorIcon(String connectorType) {
    switch (connectorType) {
      case 'Type2':
        return Image.asset(
          'assets/images/type2_plug.png',
          width: 38,
          height: 38,
          color: Color(0xFF3E789C),
        );
      case 'CCS2':
        return Image.asset(
          'assets/images/ccs2_plug.png',
          width: 40,
          height: 40,
          color: Color(0xFF3E789C),
        );
      case 'TeslaS':
        return SvgPicture.asset(
          'assets/images/tesla_s_plug.svg',
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(Color(0xFF3E789C), BlendMode.srcIn),
        );
      default:
        return Icon(
          Icons.battery_charging_full,
          size: 40,
          color: Color(0xFF3E789C),
        );
    }
  }

  static Color getColorFor(String status) {
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