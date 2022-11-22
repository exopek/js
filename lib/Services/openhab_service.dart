import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:visu/Models/models.dart';
import 'package:visu/Routes/routes.dart';

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

  Future<bool> saveSiteMap(List<Floor> floors) async {
    String siteMap = '';
    siteMap += 'sitemap ' +
        'traumhaus' +
        ' label="' +
        'Traumhaus' +
        '"\n'; // label anpassbar? watch für apple watch
    siteMap += '{\n';
    for (var floor in floors) {
      if (floor.name == '"Gruppen"') {
        siteMap += '    ' + 'Frame ' + '{\n';
      } else {
        siteMap += '    ' +
            'Frame label=' +
            floor.name +
            ' icon=' +
            floor.icon +
            ' {\n'; // 4 spaces
      }
      for (var room in floor.rooms) {
        siteMap += '        ' +
            'Text label=' +
            room.label +
            ' icon=' +
            room.icon +
            ' {\n'; // 8 spaces
        for (var item in room.devices) {
          if (item.function == 'Setpoint') {
            siteMap += '            ' +
                item.function +
                ' item=' +
                item.item +
                ' label=' +
                item.label +
                ' step=' +
                item.step! +
                ' icon=' +
                item.icon! +
                '\n';
          } else if (item.item == 'Unsichtbar') {
            siteMap += '            ' +
                item.function +
                ' item=' +
                item.item +
                ' label=' +
                item.label +
                '\n';
          } else {
            siteMap += '            ' +
                item.function +
                ' item=' +
                item.item +
                ' label=' +
                item.label +
                ' icon=' +
                item.icon! +
                '\n'; // 12 spaces
          }
        }
        siteMap += '        }\n';
      }
      siteMap += '    }\n';
    }
    siteMap += '}\n';

    Uri uri = Uri.parse(EndPoints().getEndpoints()['SAVE']);
    Response res = await post(uri, body: {'string': siteMap});
    if (res.statusCode == 200) {
      return true;
    } else {
      throw 'unable to save sitemap.';
    }
  }

  Future<List<Floor>> getSiteMap() async {
    Uri uri = Uri.parse('controller/api/load.php');
    List _subStrings = [];
    List<Floor> _result = [];
    Map<String, List> _floors = {
      'names': [],
      'icons': [],
      'rooms': [],
    };
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
              _floors['names']!
                  .add(subString.substring(endLabel + 1, startIcon));
              _floors['icons']!.add(subString.substring(endIcon + 1, endLine));
              _floorKey = subString.substring(endLabel + 1, startIcon);
            } else {
              _floors['icons']!.add('');
            }
          } else {
            _floors['names']!.add('"Gruppen"');
            _floors['icons']!.add(' ');
            _floorKey = '"Gruppen"';
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
              _roomKey = subString.substring(endLabel + 1, startIcon);
              room = Room(
                label: subString.substring(endLabel + 1, startIcon),
                icon: subString.substring(endIcon + 1, endLine),
                key: _floorKey.toString(), // Kopie des Wertes mit toString()
                devices: [],
              );
              _floors['rooms']!.add(room);
            } else {
              throw (Exception('Icon is missing'));
            }
          } else {
            throw (Exception('Label is missing'));
          }
        }

        /// Finde alles zu einem Device
        else if (!subString.contains('sitemap') &&
            !subString.contains('}') &&
            !subString.contains('{')) {
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
                    label: subString.substring(endLabel + 1, startStep),
                    item: subString.substring(endItem + 1, startLabel),
                    step: subString.substring(endStep + 1, startIcon),
                    icon:
                        subString.substring(endIcon + 1, subString.length - 1),
                    key: _roomKey,
                    function: subString.substring(hashIndex + 1, startItem),
                  );
                  //_floors['rooms']!.add(device);
                  _floors['rooms']!
                      .where((element) => element.label == _roomKey)
                      .first
                      .devices
                      .add(device);
                } else {
                  device = Device(
                    label:
                        subString.substring(endLabel + 1, subString.length - 1),
                    item: subString.substring(endItem + 1, startLabel),
                    key: _roomKey,
                    function: subString.substring(hashIndex + 1, startItem),
                  );
                  _floors['rooms']!
                      .where((element) => element.label == _roomKey)
                      .first
                      .devices
                      .add(device);
                }
              } else {
                if (subString.contains('icon')) {
                  int startIcon = subString.indexOf('icon=');
                  int endIcon = startIcon + ('icon='.length - 1);
                  device = Device(
                    label: subString.substring(endLabel + 1, startIcon),
                    item: subString.substring(endItem + 1, startLabel),
                    icon:
                        subString.substring(endIcon + 1, subString.length - 1),
                    key: _roomKey,
                    function: subString.substring(hashIndex + 1, startItem),
                  );
                  _floors['rooms']!
                      .where((element) => element.label == _roomKey)
                      .first
                      .devices
                      .add(device);
                } else {
                  device = Device(
                    label:
                        subString.substring(endLabel + 1, subString.length - 1),
                    item: subString.substring(endItem + 1, startLabel),
                    key: _roomKey,
                    function: subString.substring(hashIndex + 1, startItem),
                  );
                  _floors['rooms']!
                      .where((element) => element.label == _roomKey)
                      .first
                      .devices
                      .add(device);
                }
              }
            } else {
              throw (Exception('Label is missing'));
            }
          } else {
            throw (Exception('Item is missing'));
          }
        }
      }
      ;
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

      /// Eigentlich muss eine Liste von Floor-Objekten zurückgegeben werden
      print(_floors['rooms']![0].label);
      print(_floors['rooms']![0].devices[1].label);
      print(_floors['rooms']![1].label);
      print(_floors['rooms']![1].devices[1].label);

      for (int i = 0; i < _floors['names']!.length; i++) {
        Floor _tmpFloor = Floor(
            name: _floors['names']![i], icon: _floors['icons']![i], rooms: []);
        _floors['rooms']!.forEach((room) {
          if (room.key == _floors['names']![i]) {
            _tmpFloor.rooms.add(room);
          }
        });
        _result.add(_tmpFloor);
      }
      ;

      print(_result[0].name);
      print(_result[0].rooms[0].label);
      print(_result[0].rooms[0].devices[1].label);
      print(_result[1].name);
      print(_result[1].rooms[0].label);
      print(_result[1].rooms[0].devices[1].label);
      return _result;
    } else {
      throw 'unable to receive data.';
    }
  }
}
