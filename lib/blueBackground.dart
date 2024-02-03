import 'package:flutter/material.dart';

class BlueBackgroundBox extends StatelessWidget {
  final double top=0;
  final double left=0;
  final double widthFactor =1.0; // MediaQuery.of(context).size.width의 배수
  final double heightFactor = 0.25; // MediaQuery.of(context).size.height의 배수
  final Color color = Colors.green;

  const BlueBackgroundBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        color: color,
        width: MediaQuery.of(context).size.width * widthFactor,
        height: MediaQuery.of(context).size.height * heightFactor,
      ),
    );
  }
}