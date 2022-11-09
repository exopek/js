import 'dart:convert';

import 'package:http/http.dart';
import 'package:visu/Models/models.dart';

class OpenhabServices {
  Future<dynamic> getIP() async {
    final String ip;
    Uri uri = Uri.parse('controller/api/hello.php');
    Response res = await get(uri);
    if (res.statusCode == 200) {
      //var data = jsonDecode(res.body);
      return res.body;
    } else {
      throw 'unable to receive data.';
    }
  }

  Future getSiteMap() async {
    Uri uri = Uri.parse('controller/api/load.php');
    List _subStrings = [];
    Map<String, List> _floors = {'names': [], 'icons': [], 'rooms': [], 'roomQuantity': [], 'devices': []};
    String _floorKey = '';
    String _roomKey = '';
    Response res = await get(uri);
    if (res.statusCode == 200) {
      print(res.body);
      _subStrings.add(res.body.split('#'));
      for (int i = 0; i < _subStrings[0].length - 2; i++) {
        String subString = _subStrings[0][i].replaceAll(' ', '');
        /// Finde alles zu einer Etage
        if (subString.contains('Frame')) {
          if (subString.contains('label')) {
            int startLabel = subString.indexOf('label=');
            int endLabel = startLabel + ('label='.length - 1);
            if (subString.contains('icon')) {
              int startIcon = subString.indexOf('icon=');
              int endIcon = startIcon + ('icon='.length - 1);
              int endLine = subString.indexOf('{');
              _floors['names']!.add(subString.substring(endLabel+1, startIcon));
              _floors['icons']!.add(subString.substring(endIcon+1, endLine));
              _floorKey = subString.substring(endLabel+1, startIcon);
            } else {
              _floors['icons']!.add('');
            }

          } else {
            _floors['names']!.add('');
            _floors['icons']!.add('');
            _floorKey = 'no floor';
          }
        }
        /// Finde alles zu einem Raum
        else if (subString.contains('Text') && subString.contains('{')) {
          Room room;
          if (subString.contains('label')) {
            int startLabel = subString.indexOf('label=');
            int endLabel = startLabel + ('label='.length - 1);
            if (subString.contains('icon')) {
              int startIcon = subString.indexOf('icon=');
              int endIcon = startIcon + ('icon='.length - 1);
              int endLine = subString.indexOf('{');
              _roomKey = subString.substring(endLabel+1, startIcon);
              room = Room(
                  label: subString.substring(endLabel+1, startIcon),
                  icon: subString.substring(endIcon+1, endLine),
                  key: _floorKey.toString(), // Kopie des Wertes mit toString()
              );
              _floors['rooms']!.add(room);
            } else {
              throw(Exception('Icon is missing'));
            }
          } else {
            throw(Exception('Label is missing'));
          }
        }
        /// Finde alles zu einem Device
        else if (!subString.contains('sitemap') && !subString.contains('}') && !subString.contains('{')) {
          Device device;
          if (subString.contains('item')) {
            int startItem = subString.indexOf('item=');
            int endItem = startItem + ('item='.length - 1);
            int hashIndex = subString.indexOf('#');
            if (subString.contains('label')) {
              int startLabel = subString.indexOf('label=');
              int endLabel = startLabel + ('label='.length - 1);
              if (subString.contains('step')) {
                int startStep = subString.indexOf('step=');
                int endStep = startStep + ('step='.length - 1);
                if (subString.contains('icon')) {
                  int startIcon = subString.indexOf('icon=');
                  int endIcon = startIcon + ('icon='.length - 1);
                  device = Device(
                      label: subString.substring(endLabel+1, startStep),
                      item: subString.substring(endItem+1, startLabel),
                      step: subString.substring(endStep+1, startIcon),
                      icon: subString.substring(endIcon+1, subString.length - 1),
                      key: _roomKey,
                      function: subString.substring(hashIndex+1, startItem),
                  );
                  _floors['devices']!.add(device);
                } else {
                  device = Device(
                    label: subString.substring(endLabel+1, subString.length - 1),
                    item: subString.substring(endItem+1, startLabel),
                    key: _roomKey,
                    function: subString.substring(hashIndex+1, startItem),
                  );
                  _floors['devices']!.add(device);
                }
              } else {
                if (subString.contains('icon')) {
                  int startIcon = subString.indexOf('icon=');
                  int endIcon = startIcon + ('icon='.length - 1);
                  device = Device(
                    label: subString.substring(endLabel+1, startIcon),
                    item: subString.substring(endItem+1, startLabel),
                    icon: subString.substring(endIcon+1, subString.length - 1),
                    key: _roomKey,
                    function: subString.substring(hashIndex+1, startItem),
                  );
                  _floors['devices']!.add(device);
                } else {
                  device = Device(
                    label: subString.substring(endLabel+1, subString.length - 1),
                    item: subString.substring(endItem+1, startLabel),
                    key: _roomKey,
                    function: subString.substring(hashIndex+1, startItem),
                  );
                  _floors['devices']!.add(device);
                }
              }
            } else {
              throw(Exception('Label is missing'));
            }
          } else {
            throw(Exception('Item is missing'));
          }
        }
      };
      //print(_floors['names']);
      //print(_floors['icons']);
      //print(_floors['rooms']);
      /*
      _floors['rooms']!.forEach((element) {
        print(element.key);
      });
      */
      /// Achtung es wird vom Browser gecacht
      /*
      _floors['devices']!.forEach((element) {
        print(element.key);
        print(element.label);
      });
      */
      //print(_subStrings);
      return res.body;
    } else {
      throw 'unable to receive data.';
    }
  }
}
