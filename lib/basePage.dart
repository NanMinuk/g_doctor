import 'package:flutter/material.dart';

abstract class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: getAppBarActions(context),
      ),
      body: buildPage(context),
    );
  }

  String getTitle();

  List<Widget> getAppBarActions(BuildContext context) {
    return [];
  }
}