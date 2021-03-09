import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:olx_project_parse/screens/filter_screen/components/section_title.dart';
import 'package:olx_project_parse/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  final FilterStore filterStore;
  const OrderByField(this.filterStore);
  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title, Icon icon, OrderBy option) {
      return InkWell(
        onTap: () => filterStore.setOrderBy(option),
        child: Container(
          height: MediaQuery.of(context).size.height / 12,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: filterStore.orderBy == option
                ? Color.fromRGBO(255, 136, 0, 1)
                : Colors.white,
            border: Border.all(
              color: filterStore.orderBy == option
                  ? Colors.transparent
                  : Colors.black54,
            ),
          ),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: filterStore.orderBy == option
                          ? Colors.white
                          : Colors.black54),
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
        SectionTitle('Ordernar Por'),
        Observer(builder: (_) {
          return Row(
            children: [
              buildOption(
                'Data',
                Icon(
                  FontAwesomeIcons.calendarCheck,
                  color: filterStore.orderBy == OrderBy.DATE
                      ? Colors.white
                      : Colors.black38,
                ),
                OrderBy.DATE,
              ),
              const SizedBox(width: 16),
              buildOption(
                'Preço',
                Icon(
                  FontAwesomeIcons.moneyBill,
                  color: filterStore.orderBy == OrderBy.DATE
                      ? Colors.black38
                      : Colors.white,
                ),
                OrderBy.PRICE,
              ),
            ],
          );
        }),
      ],
    );
  }
}
