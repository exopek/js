import 'package:flutter/material.dart' hide MenuController;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:visu/views/login_page.dart';
import 'package:visu/views/visu_home_page.dart';
import 'package:visu/theme/custom_theme.dart';

import 'controller/menu_controller.dart';
import 'routes/route_generator.dart';
import 'routes/routes.dart';

void main() async {
  //final dir = await getApplicationSupportDirectory();
  //final isar = await Isar.open([], directory: dir.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: RouteGenerator.generateRoute,
        //initialRoute: RoutesName.HOME_PAGE,
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.darkTheme,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
          ],
          child: const HomePage(),
        ));
  }
}
