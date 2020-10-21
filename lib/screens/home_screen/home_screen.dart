import 'package:flutter/material.dart';
import 'package:olx_project_parse/components/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
    );
  }
}
