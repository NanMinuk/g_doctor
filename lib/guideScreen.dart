import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double topPercentage; // 세로 축 상의 위치를 비율로 조절
  final double alignX; // -1.0 (왼쪽 끝) 에서 1.0 (오른쪽 끝) 사이의 값으로 가로 축 상의 정렬 조절
  final double widthFactor;
  final double heightFactor;

  const GuideScreen({
    Key? key,
    required this.text,
    required this.textStyle,
    this.topPercentage = 0.4,
    this.alignX = 0.0, // 기본값은 중앙 정렬
    this.widthFactor = 0.8,
    this.heightFactor = 0.1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      top: screenHeight * topPercentage,
      left: (screenWidth - screenWidth * widthFactor) / 2 + (screenWidth * alignX) / 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        width: screenWidth * widthFactor,
        height: screenHeight * heightFactor,
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}