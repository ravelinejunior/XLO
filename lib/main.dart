import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/screens/base_screen/base_screen.dart';
import 'package:olx_project_parse/stores/page_store.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setUpLocatores();
  runApp(MyApp());

/*   
ADICIONAR CLASSE AO PARSE

final category = ParseObject('Categories')
    ..set('Title', "Jontex")
    ..set('Position', 2);

  final response = await category.save();

  print(response.success); */

  /* for (int i = 0; i < 100; i++) {
    final category = ParseObject('Categories');
    category.set('Title', "Carro $i");
    category.set('Position', i);
    final response = await category.save();
    print("Salvo classe $i\nResponse count: ${response.count} ");
  } */

/* 

EDITAR CLASSE JA CRIADA POR ID

  final category = ParseObject('Categories')
    ..objectId = 'sqF5yl4KiU'
    ..set('Title', "Magazine Luiza");

  final response = await category.update();

  print(response.results.first); */

  // LEITURA DE DADOS

//normal
  final response = await ParseObject('Categories').getObject('sqF5yl4KiU');
//  if (response.success) print(response.result);

/* //leitura total de dados
  final responseTotalData = await ParseObject('Categories').getAll();
  if (responseTotalData.success) {
    for (final object in responseTotalData.result) {
      // print(object);
    }
  }

// queries
  final query = QueryBuilder(ParseObject('Categories'));
  query.whereEqualTo('Position', 2);
  query.whereContains('Title', 'Car');
  final responseQuery = await query.query();
  if (responseQuery.success) {
    for (final qResult in responseQuery.result) {
      print(qResult);
    }
  } */

  //codigo
}

void setUpLocatores() {
  GetIt.I.registerSingleton(PageStore());
}

//inicializar parse
Future<void> initializeParse() async {
  await Parse().initialize(
    "Y9ItrTc55ob6YeIvgTXbwS44qatzWV8guMLxh9Em",
    "https://parseapi.back4app.com/",
    clientKey: "xTfJnG558e9xebPSqLgaGJf670LQtYLKzp2brrSL",
    autoSendSessionId: true,
    debug: true,
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: BaseScreen(),
    );
  }
}
