import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visu/controller/menu_controller.dart';
import 'package:visu/responsive/responsive.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List _sideBarContent = ['', 'Dashboard', 'Einstellungen'];
  List _mobileSideBarContent = [
    '',
    Icon(
      Icons.home,
      color: Colors.white,
    ),
    Icon(
      Icons.settings,
      color: Colors.white,
    )
  ];

  @override
  Widget build(BuildContext context) {
    var menuController = Provider.of<MenuController>(context);
    return Drawer(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const DrawerHeader(
                  child: Image(image: AssetImage('assets/issendorff.png')),
                );
              } else {
                return Responsive(
                  desktop: DrawerListTile(
                      withIcon: false,
                      title: _sideBarContent[index],
                      press: () {
                        menuController.setMenuIndex(index);
                        menuController.setShowSettingsContentStatus(false);
                      }),
                  mobile: DrawerListTile(
                      withIcon: true,
                      icon: _mobileSideBarContent[index],
                      press: () {
                        menuController.setMenuIndex(index);
                        menuController.setShowSettingsContentStatus(false);
                      }),
                );
              }
            })
        /*
          DrawerListTile(
            title: "Dashboard",
            //svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "OpenHab",
            //svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Einstellungen",
            //svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          */

        );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    this.title,
    this.icon,
    required this.withIcon,
    //required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String? title;
  final VoidCallback press;
  final Icon? icon;
  final bool withIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      //tileColor: Colors.black,
      /*
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      */
      title: withIcon
          ? icon
          : Text(
              title ?? '',
              style: TextStyle(color: Colors.white54),
            ),
    );
  }
}
