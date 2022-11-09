import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:visu/Controller/menu_controller.dart';
import 'package:visu/CustomWidgets/create_list_pro_xml.dart';
import 'package:visu/CustomWidgets/dashboard.dart';
import 'package:visu/CustomWidgets/edit_sitemap.dart';
import 'package:visu/CustomWidgets/header.dart';
import 'package:visu/CustomWidgets/openhab.dart';
import 'package:visu/CustomWidgets/settings.dart';
import 'package:visu/CustomWidgets/sidebar.dart';
import 'package:visu/Responsive/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> dashContent = [Container(), Dashboard(), Openhab(), Settings()];
  List<Widget> settingsContent = [
    Container(
      color: Colors.green,
    ),
    const EditSiteMap(),
    const CreateListProXml(),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellowAccent,
    ),
    Container(
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var menuController = Provider.of<MenuController>(context);
    return Scaffold(
      //key: context.read<MenuController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Consumer<MenuController>(builder: (context, data, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.getShowSideBarStatus() && !Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                //menuController.setShowSideBarStatus(false),
                const Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),

              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: data.getShowSettingsContentStatus()
                    ? settingsContent[data.getSettingsIndex()]
                    : dashContent[data.getCurrentIndex()],
              ),
            ],
          );
        }),
      ),
    );
  }
}
