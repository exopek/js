import 'package:flutter/material.dart';
import 'package:visu/Views/visu_home_page.dart';
import 'package:visu/Routes/routes.dart';
import 'package:visu/Routes/route_page_animation.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.HOME_PAGE:
        return GeneratePageRoute(
            widget: HomePage(), routeName: settings.name!);
      default:
        return GeneratePageRoute(
            widget: HomePage(), routeName: settings.name!);
    }
  }
}