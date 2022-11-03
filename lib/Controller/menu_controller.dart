import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  int _index = 0;
  bool _showSideBar = false;
  bool _showSettingsContent = false;
  int _settingsIndex = 0;
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int getCurrentIndex() => _index;

  bool getShowSideBarStatus() => _showSideBar;

  bool getShowSettingsContentStatus() => _showSettingsContent;

  int getSettingsIndex() => _settingsIndex;

  setShowSideBarStatus(bool sideBarStatus) {
    _showSideBar = sideBarStatus;
    notifyListeners();
  }

  setShowSettingsContentStatus(bool settingsContentStatus) {
    _showSettingsContent = settingsContentStatus;
  }

  setMenuIndex(int currentIndex) {
    _index = currentIndex;
    notifyListeners();
  }

  setSettingsIndex(int currentSettingsIndex) {
    _settingsIndex = currentSettingsIndex;
    notifyListeners();
  }
}