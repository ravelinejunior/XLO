import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: IconButton(icon: null, onPressed: null)),
            ),
          ),
          top: 2,
          left: 2,
          right: 2,
        ),
      ],
    );
  }
}
