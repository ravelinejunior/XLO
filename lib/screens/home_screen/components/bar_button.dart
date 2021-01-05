import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  final BoxDecoration decoration;
  final String label;
  final VoidCallback onTap;
  final Color splashColor;
  BarButton({this.decoration, this.label, this.onTap, this.splashColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: splashColor,
        onTap: onTap,
        child: Container(
          decoration: decoration,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 14,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
