import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceField extends StatelessWidget {
  final String label;
  final Function(int) onChanged;
  final int initialValue;

  const PriceField({this.label, this.onChanged, this.initialValue});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.all(16),
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black.withAlpha(100),
          ),
          prefixText: 'R\$ ',
          isDense: true,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: false),
        ],
        onChanged: (value) {
          onChanged(
            int.tryParse(value.replaceAll('.', '')),
          );
        },
        initialValue: initialValue?.toString(),
        textInputAction: TextInputAction.go,
      ),
    );
  }
}
