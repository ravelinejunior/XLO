import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_project_parse/screens/filter_screen/components/section_title.dart';
import 'package:olx_project_parse/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  const VendorTypeField(this.filterStore);
  final FilterStore filterStore;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle('Tipo de Anunciante'),
        Observer(
          builder: (_) {
            return Wrap(
              runSpacing: 4,
              children: [
                InkWell(
                  onTap: () {
                    if (filterStore.isTypeParticular) {
                      if (filterStore.isTypeProfessional)
                        filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                      else
                        filterStore.selectVendorType(VENDOR_TYPE_PROFESSIONAL);
                    } else {
                      filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                    }
                  },
                  splashColor: Color.fromRGBO(255, 136, 0, 1).withAlpha(150),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.height / 4.7,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      color: filterStore.isTypeParticular
                          ? Color.fromRGBO(255, 136, 0, 1)
                          : Colors.transparent,
                      border: Border.all(
                        color: filterStore.isTypeParticular
                            ? Colors.transparent
                            : Colors.black54,
                      ),
                    ),
                    child: Text(
                      'Particular',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: filterStore.isTypeParticular
                              ? Colors.white
                              : Colors.black54,
                          fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    if (filterStore.isTypeProfessional) {
                      if (filterStore.isTypeParticular)
                        filterStore.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                      else
                        filterStore.selectVendorType(VENDOR_TYPE_PARTICULAR);
                    } else {
                      filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }
                  },
                  splashColor: Color.fromRGBO(255, 136, 0, 1).withAlpha(150),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.height / 4.7,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      color: filterStore.isTypeProfessional
                          ? Color.fromRGBO(255, 136, 0, 1)
                          : Colors.transparent,
                      border: Border.all(
                        color: filterStore.isTypeProfessional
                            ? Colors.transparent
                            : Colors.black54,
                      ),
                    ),
                    child: Text(
                      'Professional',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: filterStore.isTypeProfessional
                              ? Colors.white
                              : Colors.black54,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
