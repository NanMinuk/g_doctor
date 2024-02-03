import 'package:flutter/material.dart';

class WhiteBackgroundbox extends StatelessWidget {
  final double topPercentage =0.7;
  final double heightPercentage = 0.3;
  final Color color = Colors.white;

  const WhiteBackgroundbox({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: screenHeight * topPercentage,
      left: 0,
      child: Container(
        color: color,
        width: screenWidth,
        height: screenHeight * heightPercentage,
      ),
    );
  }
}