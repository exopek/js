import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visu/controller/menu_controller.dart';
import 'package:visu/responsive/responsive.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  List<String> _headerText = ['', 'Dashboard', 'Einstellungen'];
  List<String> _headerSettingsText = [
    'PCHK Konfigurieren',
    'Listenansicht bearbeiten',
    'Listenansicht Erstellen',
    'Mobile Benutzung einrichten',
    'Extern anbinden',
    'Backup'
  ];

  @override
  Widget build(BuildContext context) {
    var menuController = Provider.of<MenuController>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 30.0),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                menuController.setShowSideBarStatus(true);
              },
            ),
          if (!Responsive.isMobile(context))
            Consumer<MenuController>(builder: (context, data, child) {
              return Text(
                data.getShowSettingsContentStatus()
                    ? _headerSettingsText[data.getSettingsIndex()]
                    : _headerText[data.getCurrentIndex()],
                style: const TextStyle(color: Colors.white, fontSize: 30.0),
              );
            }),
        ],
      ),
    );
  }
}
