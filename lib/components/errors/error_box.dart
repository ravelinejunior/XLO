import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String message;
  const ErrorBox({this.message});
  @override
  Widget build(BuildContext context) {
    if (message == null)
      return Container();
    else
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.red,
          child: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 40),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Eita! $message. Por favor, tente novamente.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
