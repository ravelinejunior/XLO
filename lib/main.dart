import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_project_parse/managers/user_manager/user_manager_store.dart';
import 'package:olx_project_parse/repositories/repo_category/category_repository.dart';
import 'package:olx_project_parse/screens/base_screen/base_screen.dart';
import 'package:olx_project_parse/screens/category_screen/category_screen.dart';
import 'package:olx_project_parse/stores/category_store.dart';
import 'package:olx_project_parse/stores/page_store.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setUpLocatores();
  runApp(MyApp());
}

//acessar managers de qualquer lugar do app
void setUpLocatores() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
}

//inicializar parse
Future<void> initializeParse() async {
  try {
    await Parse().initialize(
      "Y9ItrTc55ob6YeIvgTXbwS44qatzWV8guMLxh9Em",
      "https://parseapi.back4app.com/",
      clientKey: "xTfJnG558e9xebPSqLgaGJf670LQtYLKzp2brrSL",
      autoSendSessionId: true,
      debug: true,
      coreStore: await CoreStoreSembastImp.getInstance(),
    );
    print("Logado");
  } catch (e) {
    print(e);
    await Parse().initialize(
      "Y9ItrTc55ob6YeIvgTXbwS44qatzWV8guMLxh9Em",
      "https://parseapi.back4app.com/",
      clientKey: "xTfJnG558e9xebPSqLgaGJf670LQtYLKzp2brrSL",
      autoSendSessionId: true,
      debug: true,
    );
    print("Sem usuario");
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.purple,
        appBarTheme: AppBarTheme(elevation: 0),
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: BaseScreen(),
    );
  }
}
