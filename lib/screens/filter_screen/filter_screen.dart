import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterScreen extends StatelessWidget {
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final focusNode4 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrar Busca'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 16, left: 8, right: 8),
                    child: Text(
                      'Localização',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      labelText: "Estado",
                      labelStyle: TextStyle(
                        color: Colors.black.withAlpha(100),
                      ),
                      suffixIcon:
                          Icon(Icons.keyboard_arrow_down, color: Colors.purple),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: focusNode1,
                    onFieldSubmitted: (value) => focusNode2.requestFocus(),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      labelText: "Cidade",
                      labelStyle: TextStyle(
                        color: Colors.black.withAlpha(100),
                      ),
                      suffixIcon:
                          Icon(Icons.keyboard_arrow_down, color: Colors.purple),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    focusNode: focusNode2,
                    onTap: () => focusNode2.unfocus(),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 16, left: 8, right: 8),
                    child: Text(
                      'Ordenar Por',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 12,
                          child: RaisedButton.icon(
                            color: Colors.purple,
                            shape: StadiumBorder(),
                            splashColor: Colors.pink.withAlpha(200),
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.calendarCheck,
                              color: Colors.white,
                            ),
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Data',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          height: MediaQuery.of(context).size.height / 12,
                          child: RaisedButton.icon(
                            color: Colors.purple,
                            shape: StadiumBorder(),
                            splashColor: Colors.pink.withAlpha(200),
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.moneyBillWave,
                              color: Colors.white,
                              size: 22,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Preço',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 16, left: 8, right: 8),
                    child: Text(
                      'Preço',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            labelText: "Min",
                            labelStyle: TextStyle(
                              color: Colors.black.withAlpha(100),
                            ),
                            isDense: true,
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.next,
                          focusNode: focusNode3,
                          onFieldSubmitted: (value) =>
                              focusNode4.requestFocus(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            labelText: "Max",
                            labelStyle: TextStyle(
                              color: Colors.black.withAlpha(100),
                            ),
                            isDense: true,
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.done,
                          focusNode: focusNode4,
                          onFieldSubmitted: (value) => focusNode4.unfocus(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 16, left: 8, right: 8),
                    child: Text(
                      'Tipo de Anunciante',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 12,
                            child: RaisedButton(
                              color: Colors.purple,
                              shape: StadiumBorder(),
                              splashColor: Colors.pink.withAlpha(200),
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Particular',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 12,
                            child: RaisedButton(
                              color: Colors.purple,
                              shape: StadiumBorder(),
                              splashColor: Colors.pink.withAlpha(200),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Profissional',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: RaisedButton(
                      color: Colors.deepOrangeAccent,
                      shape: StadiumBorder(),
                      splashColor: Colors.orange.withAlpha(200),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Filtrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
