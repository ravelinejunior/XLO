import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  SearchDialog({this.currentSearch})
      : controller = TextEditingController(text: currentSearch);
  final String currentSearch;
  final controller;
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
              controller: controller,
              decoration: InputDecoration(
                hintText: "Pesquisa",
                hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
                  onPressed: Navigator.of(context).pop,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close, color: Colors.grey[700]),
                  onPressed: controller.clear,
                ),
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
              autofocus: true,
              textInputAction: TextInputAction.search,
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
