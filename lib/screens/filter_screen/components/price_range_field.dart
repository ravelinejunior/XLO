import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/components/errors/error_box.dart';
import 'package:olx_project_parse/screens/filter_screen/components/price_field.dart';
import 'package:olx_project_parse/screens/filter_screen/components/section_title.dart';
import 'package:olx_project_parse/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  final FilterStore filterStore;
  const PriceRangeField(this.filterStore);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Preço'),
        Row(
          children: [
            PriceField(
              label: 'Min',
              onChanged: filterStore.setMinPrice,
              initialValue: filterStore.minPrice,
            ),
            const SizedBox(width: 12),
            PriceField(
              label: 'Max',
              onChanged: filterStore.setMaxPrice,
              initialValue: filterStore.maxPrice,
            ),
          ],
        ),
        Observer(
          builder: (_) {
            if (filterStore.priceError != null)
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ErrorBox(
                  message: filterStore.priceError,
                ),
              );
            else
              return Container();
          },
        ),
      ],
    );
  }
}
