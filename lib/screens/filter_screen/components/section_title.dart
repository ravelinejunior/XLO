import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  SectionTitle(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromRGBO( 255, 136, 0,1),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
