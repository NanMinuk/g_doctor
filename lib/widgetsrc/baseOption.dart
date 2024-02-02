import 'package:flutter/material.dart';

BoxDecoration roundBoxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black26, // 기존의 0.2 대신에 black26을 사용할 수도 있습니다.
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  );
}

TextStyle standardTextStyle({Color color = Colors.black, double fontSize = 16.0, FontWeight fontWeight = FontWeight.bold}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

BoxDecoration MicBoxDecoration({Color color = Colors.blue, double opacity = 0.2, double spreadRadius = 2, double blurRadius = 4}) {
  return BoxDecoration(
    shape: BoxShape.circle,
    color: color,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(opacity),
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

AppBar homeAppBar({required String title}) {
  return AppBar(
    toolbarHeight: 80.0,
    title: Container(
      margin: const EdgeInsets.only(top: 25),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Noto Sans',
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.blue,
  );
}

AppBar midAppBar({required String title, required BuildContext context}) {
  return AppBar(
    toolbarHeight: 80.0,
    title: Container(
      margin: const EdgeInsets.only(top: 25),
      child: Text(
        title, // title 파라미터를 사용
        style: TextStyle(
          fontFamily: 'Noto Sans',
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.blue,
    leading: Container(
      margin: const EdgeInsets.only(top: 25),
      child: IconButton(
        onPressed: () {
          // 뒤로가기 기능
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 40, // 아이콘의 크기
        ),
      ),
    ),
  );
}



