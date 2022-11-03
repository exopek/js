import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visu/Views/login_page.dart';
import 'package:visu/Views/visu_home_page.dart';
import 'package:visu/Theme/custom_theme.dart';

import 'Controller/menu_controller.dart';
import 'Routes/route_generator.dart';
import 'Routes/routes.dart';

void main() {
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
      )
    );
  }
}


