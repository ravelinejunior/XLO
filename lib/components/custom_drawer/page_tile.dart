import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {
  const PageTile({this.label, this.iconData, this.onTap, this.highlighted});
  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: StadiumBorder(),
      hoverColor: Colors.red,
      title: Text(
        label,
        style: TextStyle(
          color: highlighted ? Colors.purple : Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        iconData,
        color: highlighted ? Colors.purple : Colors.black54,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
