import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/stores/cep_store.dart';

class CepField extends StatelessWidget {
  final CepStore cepStore = CepStore();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: InputDecoration(
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.all(16),
            labelText: "CEP *",
            labelStyle: TextStyle(
              color: Colors.black.withAlpha(100),
            ),
            prefixIcon: Icon(Icons.location_on),
            isDense: true,
          ),
          inputFormatters: [
            CepInputFormatter(),
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          onChanged: cepStore.setCep,
        ),
        const SizedBox(height: 24),
        Observer(
          builder: (_) {
            if (cepStore.address == null &&
                cepStore.error == null &&
                !cepStore.loading)
              return Container();
            else if (cepStore.address == null &&
                cepStore.error == null &&
                cepStore.loading)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                  strokeWidth: 4,
                ),
              );
            else if (cepStore.error != null)
              return Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.redAccent.withAlpha(100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    cepStore.error,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            else {
              final address = cepStore.address;
              return Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.purple.withAlpha(200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 7,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Localização: ${address.disctrict}, ${address.city.name} - ${address.uf.name}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
