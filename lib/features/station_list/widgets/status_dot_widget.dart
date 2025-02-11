import 'package:flutter/material.dart';
import '../../../core/utils/util_methods.dart';

class StatusDotWidget extends StatelessWidget {
  final double diameter;
  final Color? color;
  final String status;

  const StatusDotWidget({
    required this.diameter,
    this.color = const Color(0xFF3BB44D),
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: UtilMethods.getColorFor(status),
        shape: BoxShape.circle,
      ),
    );
  }
}