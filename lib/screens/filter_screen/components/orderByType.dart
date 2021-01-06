import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:olx_project_parse/screens/filter_screen/components/section_title.dart';
import 'package:olx_project_parse/stores/filter_store.dart';

class OrderByType extends StatelessWidget {
  final FilterStore filterStore;
  const OrderByType(this.filterStore);
  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title, OrderByTypeStore option) {
      return InkWell(
        onTap: () {
          filterStore.setOrderByType(option);
        },
        splashColor: Colors.pink.withAlpha(150),
        child: Container(
          height: MediaQuery.of(context).size.height / 12,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: filterStore.orderByType == option
                ? Colors.purple
                : Colors.white,
            border: Border.all(
              color: filterStore.orderByType.index != option.index
                  ? Colors.black54
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: filterStore.orderByType == option
                        ? Colors.white
                        : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Tipo Anunciante'),
        Observer(builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildOption('Particular', OrderByTypeStore.PARTICULAR),
              const SizedBox(width: 4),
              buildOption('Profissional', OrderByTypeStore.PROFESSIONAL),
            ],
          );
        }),
      ],
    );
  }
}
