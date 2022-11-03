import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visu/Controller/menu_controller.dart';
import 'package:visu/CustomWidgets/header.dart';
import 'package:visu/Responsive/responsive.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  List settingsChoice = [];


  @override
  void initState() {
    settingsChoice = ['PCHK Konfigurieren', 'Listenansicht bearbeiten', 'Listenanischt Erstellen', 'Mobile Benutzung einrichten', 'Extern anbinden', 'Backup'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Responsive(
                          mobile: _grid(
                              context,
                              crossAxisCount: _size.width < 650 ? 2 : 4,
                              childAspectRatio: _size.width < 650 ? 1.3 : 1,
                              defaultPadding: 16.0,
                              choice: settingsChoice
                          ),
                          tablet: _grid(
                              context,
                              crossAxisCount: 4,
                              childAspectRatio: 1,
                              defaultPadding: 16.0,
                              choice: settingsChoice
                          ),
                          desktop: _grid(
                              context,
                              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                              crossAxisCount: 4,
                              defaultPadding: 16.0,
                              choice: settingsChoice
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

Widget _grid(BuildContext context, {required crossAxisCount, required defaultPadding, required childAspectRatio, required List choice}) {
  var menuController = Provider.of<MenuController>(context);
  return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                  )
              ),
              onPressed: () {
                menuController.setSettingsIndex(index);
                menuController.setShowSettingsContentStatus(true);
              },
              child: Text(choice[index]),
            )
        ),
  );
}


