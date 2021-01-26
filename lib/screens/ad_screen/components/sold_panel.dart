import 'package:flutter/material.dart';
import 'package:olx_project_parse/models/ad.dart';

class SoldPanel extends StatelessWidget {
  const SoldPanel(this.ad);
  final Ad ad;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.money_off),
                const SizedBox(width: 8),
                Text(
                  'VENDIDO',
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2.8,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
