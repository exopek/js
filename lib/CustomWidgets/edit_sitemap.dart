import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visu/models/models.dart';
import 'package:visu/responsive/responsive.dart';
import 'package:visu/services/openhab_service.dart';
import 'package:visu/customWidgets/header.dart';

class EditSiteMap extends StatefulWidget {
  const EditSiteMap({Key? key}) : super(key: key);

  @override
  State<EditSiteMap> createState() => _EditSiteMapState();
}

class _EditSiteMapState extends State<EditSiteMap> {
  late List<Floor> _floors;
  late List<Room> _rooms;
  late bool _isLoading;
  late int _floorIndex;
  late int _roomIndex;
  late int _selectedDevice;
  late String _newRoom;
  late String _selectetdType;
  late String _selectedIcon;
  late Map<String, List> _possibleLabels;
  late TextEditingController _deviceNameController;
  late ScrollController _scrollController;
  ValueNotifier<bool> _deviceSaved = ValueNotifier(false);

  List<String> item = [
    "GeeksforGeeks",
    "Flutter",
    "Developer",
    "Android",
    "Programming",
    "CplusPlus",
    "Python",
    "javascript"
  ];

  List<Device> devices = [
    Device(
        label: 'Device 1', item: 'Item 1', key: 'Room 1', function: 'Switch'),
    Device(
        label: 'Device 2', item: 'Item 2', key: 'Room 1', function: 'Switch'),
    Device(
        label: 'Device 3', item: 'Item 3', key: 'Room 1', function: 'Switch'),
    Device(
        label: 'Device 4', item: 'Item 4', key: 'Room 2', function: 'Switch'),
    Device(
        label: 'Device 5', item: 'Item 5', key: 'Room 2', function: 'Switch'),
  ];

  Map<String, List<String>> icons = {
    'slider': ['assets/icons/slider.png', 'slider'],
    'relais': ['assets/icons/relais.png', 'relais'],
    'temperature': ['assets/icons/temperature.png', 'temperature'],
    'window': ['assets/icons/window.png', 'window'],
    'switch': ['assets/icons/switch.png', 'switch'],
    'regler': ['assets/icons/regler.png', 'regler'],
    'regler_sperre': ['assets/icons/regler_sperre.png', 'regler_sperre'],
    'light': ['assets/icons/light.png', 'light'],
    'rollershutter': ['assets/icons/rollershutter.png', 'rollershutter'],
    'humidity': ['assets/icons/humidity.png', 'humidity'],
    'motion': ['assets/icons/motion.png', 'motion'],
    'kidsroom_icon': ['assets/icons/kidsroom.png', 'kidsroom_icon'],
    'bath': ['assets/icons/bath.png', 'bath'],
    'bedroom': ['assets/icons/bedroom.png', 'bedroom'],
    'kitchen': ['assets/icons/kitchen.png', 'kitchen'],
    'changingroom': ['assets/icons/changingroom.png', 'changingroom'],
    'diningroom': ['assets/icons/diningroom.png', 'diningroom'],
    'corridor': ['assets/icons/corridor.png', 'corridor'],
    'vk': ['assets/icons/vk.png', 'vk'],
    'door': ['assets/icons/door.png', 'door'],
    'office': ['assets/icons/office.png', 'office'],
    'terrace': ['assets/icons/terrace.png', 'terrace'],
    'party': ['assets/icons/party.png', 'party'],
    'toilet': ['assets/icons/toilet.png', 'toilet'],
    'garden': ['assets/icons/garden.png', 'garden'],
    'suitcase': ['assets/icons/suitcase.png', 'suitcase'],
    'pantry': ['assets/icons/pantry.png', 'pantry'],
    'lcn': ['assets/icons/slider.png', 'lcn'],
    'Unbekannt': ['assets/icons/slider.png', 'Unbekannt'],
    'contact': ['assets/icons/slider.png', 'contact']
  };

  Map<String, String> types = {
    'Schalter': 'Switch',
    'Slider': 'Slider',
    'Messwert': 'Text',
    'Regler': 'Setpoint',
    'Binärsensor': 'Default',
    'Jalousie': 'Default',
  };

  List<Floor> _floorDummy = [
    Floor(
      icon: 'garden',
      name: 'Floor 1',
      rooms: [
        Room(
            icon: 'bedroom',
            label: '"Room 1"',
            devices: [
              Device(
                  icon: 'light',
                  label: '"Device 1"',
                  item: 'Item 1',
                  key: 'Room 1',
                  function: 'Switch'),
              Device(
                  icon: 'switch',
                  label: '"Device 2"',
                  item: 'Item 2',
                  key: 'Room 1',
                  function: 'Switch'),
              Device(
                  icon: 'slider',
                  label: '"Device 3"',
                  item: 'Item 3',
                  key: 'Room 1',
                  function: 'Switch'),
            ],
            key: 'Floor 1'),
        Room(
            icon: 'kitchen',
            label: '"Room 2"',
            devices: [
              Device(
                  icon: 'switch',
                  label: '"Device 4"',
                  item: 'Item 4',
                  key: 'Room 2',
                  function: 'Switch'),
              Device(
                  icon: 'temperature',
                  label: '"Device 5"',
                  item: 'Item 5',
                  key: 'Room 2',
                  function: 'Switch'),
            ],
            key: 'Floor 1'),
      ],
    ),
    Floor(
      icon: 'garden',
      name: 'Floor 2',
      rooms: [
        Room(
            icon: 'changingroom',
            label: '"Room 3"',
            devices: [
              Device(
                  icon: 'motion',
                  label: '"Device 6"',
                  item: 'Item 6',
                  key: 'Room 3',
                  function: 'Switch'),
              Device(
                  icon: 'light',
                  label: '"Device 7"',
                  item: 'Item 7',
                  key: 'Room 3',
                  function: 'Switch'),
              Device(
                  icon: 'rollershutter',
                  label: '"Device 8"',
                  item: 'Item 8',
                  key: 'Room 3',
                  function: 'Switch'),
            ],
            key: 'Floor 2'),
        Room(
            icon: 'diningroom',
            label: '"Room 4"',
            devices: [
              Device(
                  icon: 'switch',
                  label: '"Device 9"',
                  item: 'Item 9',
                  key: 'Room 4',
                  function: 'Switch'),
              Device(
                  icon: 'relais',
                  label: '"Device 10"',
                  item: 'Item 10',
                  key: 'Room 4',
                  function: 'Switch'),
            ],
            key: 'Floor 2'),
      ],
    ),
  ];

  void _showChangeRoomAttributes(int index) {
    /// comment showdialog

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: Color.fromRGBO(25, 30, 30, 1.0).withOpacity(0.5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _floors[_floorIndex].rooms.removeAt(index);
                              });
                              _isLoading = true;
                              _deviceSaved.value = true;
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Text(
                        'Raum ändern',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text('Label:',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ),

                        /// show String without first and last character
                        SizedBox(
                          width: 200.0,
                          child: TextField(
                            controller: _deviceNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: _floors[_floorIndex]
                                  .rooms[_roomIndex]
                                  .label
                                  .substring(
                                      1,
                                      _floors[_floorIndex]
                                              .rooms[index]
                                              .label
                                              .length -
                                          1),
                              hintStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text('Icon:',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ),

                        /// Es soll der aktuelle Icon angezeigt werden
                        if (_selectedIcon != '') ...[
                          SizedBox(
                            width: 50.0,
                            child: Image.asset(icons[_selectedIcon]![0]),
                          ), // Device mit Icon
                        ] else ...[
                          SizedBox(
                            width: 50.0,
                            child: Image.asset(
                              icons[_floors[_floorIndex].rooms[index].icon]![
                                      0] ??
                                  'assets/icons/slider.png',
                              fit: BoxFit.contain,
                            ),
                          ), // Default Icon
                          /*color: Colors.white*/
                        ],

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: DropdownButton(
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              items: icons.keys
                                  .map((String key) => DropdownMenuItem(
                                        value: key,
                                        child: Text(key),
                                      ))
                                  .toList(),
                              icon: const Icon(Icons.arrow_downward),
                              hint: Text(_selectedIcon == ''
                                  ? _floors[_floorIndex].rooms[index].icon
                                  : _selectedIcon),
                              onChanged: (String? newValue) {
                                setState(() {
                                  print(_selectedIcon);
                                  _selectedIcon = newValue!;
                                });
                              }),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.4)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.orangeAccent))),
                          onPressed: () {
                            setState(() {
                              if (_selectedIcon != '') {
                                _floors[_floorIndex].rooms[index].icon =
                                    _selectedIcon;
                              }
                              if (_deviceNameController.text.isNotEmpty) {
                                _floors[_floorIndex].rooms[index].label =
                                    '"' + _deviceNameController.text + '"';
                              }

                              /// Bereinigung
                              _deviceNameController.clear();
                              _isLoading = true;
                              _selectedIcon = '';
                              _newRoom = '';
                              _deviceSaved.value = true;
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Speichern',
                            style: TextStyle(
                                fontFamily: 'FiraSansExtraCondensed',
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.4)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.red))),
                          onPressed: () {
                            _deviceNameController.clear();
                            _selectedIcon = '';
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Abbrechen',
                            style: TextStyle(
                                fontFamily: 'FiraSansExtraCondensed',
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  /// Change Name, Icon and Room of a Device
  void _showChangeDeviceAttributes() {
    /// comment showdialog

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: Color.fromRGBO(25, 30, 30, 1.0).withOpacity(0.5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _floors[_floorIndex]
                                    .rooms[_roomIndex]
                                    .devices
                                    .removeAt(_selectedDevice);
                              });
                              _isLoading = true;
                              _deviceSaved.value = true;
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Text(
                        'Item ändern',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text('Label:',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ),

                        /// show String without first and last character
                        SizedBox(
                          width: 200.0,
                          child: TextField(
                            controller: _deviceNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: _floors[_floorIndex]
                                  .rooms[_roomIndex]
                                  .devices[_selectedDevice]
                                  .label
                                  .substring(
                                      1,
                                      _floors[_floorIndex]
                                              .rooms[_roomIndex]
                                              .devices[_selectedDevice]
                                              .label
                                              .length -
                                          1),
                              hintStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text('Name:',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ),
                        SelectableText(
                          _floors[_floorIndex]
                              .rooms[_roomIndex]
                              .devices[_selectedDevice]
                              .item,
                          style: TextStyle(color: Colors.grey, fontSize: 20.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text('Icon:',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ),

                        /// Es soll der aktuelle Icon angezeigt werden
                        if (_selectedIcon != '') ...[
                          Image.asset(
                              icons[_selectedIcon]![0]), // Device mit Icon
                        ] else ...[
                          Image.asset(icons[_floors[_floorIndex]
                                  .rooms[_roomIndex]
                                  .devices[_selectedDevice]
                                  .icon]![0] ??
                              'assets/icons/slider.png'), // Device mit Icon
                          /*color: Colors.white*/
                        ],

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: DropdownButton(
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              items: icons.keys
                                  .map((String key) => DropdownMenuItem(
                                        value: key,
                                        child: Text(key),
                                      ))
                                  .toList(),
                              icon: const Icon(Icons.arrow_downward),
                              hint: Text(_selectedIcon == ''
                                  ? _floors[_floorIndex]
                                      .rooms[_roomIndex]
                                      .devices[_selectedDevice]
                                      .icon!
                                  : _selectedIcon),
                              onChanged: (String? newValue) {
                                setState(() {
                                  print(_selectedIcon);
                                  _selectedIcon = newValue!;
                                });
                              }),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text('Verschieben in Raum:',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ),
                        DropdownButton(
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            items: _getRooms()
                                .map((Room room) => DropdownMenuItem(
                                      value: room,
                                      child: Text(room.label),
                                    ))
                                .toList(),
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (Room? newValue) {
                              setState(() {
                                /// _newRoom als String um dann in der Floor Liste danach zu suchen
                                _newRoom = newValue!.label;
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.4)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.orangeAccent))),
                          onPressed: () {
                            setState(() {
                              if (_newRoom != '') {
                                List<int> _floorAndRoomIndex =
                                    _getRoomIndex(_newRoom);

                                /// Room Key ändern
                                _floors[_floorIndex]
                                    .rooms[_roomIndex]
                                    .devices[_selectedDevice]
                                    .key = _newRoom;

                                /// Name ändern
                                if (_deviceNameController.text.isNotEmpty) {
                                  _floors[_floorIndex]
                                      .rooms[_roomIndex]
                                      .devices[_selectedDevice]
                                      .label = _deviceNameController.text;
                                }

                                /// Icon ändern
                                if (_selectedIcon != '') {
                                  _floors[_floorIndex]
                                      .rooms[_roomIndex]
                                      .devices[_selectedDevice]
                                      .icon = _selectedIcon;
                                }

                                /// Device in neuen Room verschieben
                                _floors[_floorAndRoomIndex[0]]
                                    .rooms[_floorAndRoomIndex[1]]
                                    .devices
                                    .add(_floors[_floorIndex]
                                        .rooms[_roomIndex]
                                        .devices[_selectedDevice]);

                                /// Device aus altem Room löschen
                                _floors[_floorIndex]
                                    .rooms[_roomIndex]
                                    .devices
                                    .removeAt(_selectedDevice);
                              } else {
                                /// Name ändern
                                print(_deviceNameController.text.toString());
                                if (_deviceNameController.text.isNotEmpty) {
                                  _floors[_floorIndex]
                                          .rooms[_roomIndex]
                                          .devices[_selectedDevice]
                                          .label =
                                      '"' + _deviceNameController.text + '"';
                                }

                                /// Icon ändern
                                if (_selectedIcon != '') {
                                  _floors[_floorIndex]
                                      .rooms[_roomIndex]
                                      .devices[_selectedDevice]
                                      .icon = _selectedIcon;
                                }
                              }

                              /// Bereinigung
                              _deviceNameController.clear();
                              _isLoading = true;
                              _selectedIcon = '';
                              _newRoom = '';
                              _deviceSaved.value = true;
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Speichern',
                            style: TextStyle(
                                fontFamily: 'FiraSansExtraCondensed',
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.4)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.red))),
                          onPressed: () {
                            _deviceNameController.clear();
                            _selectedIcon = '';
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Abbrechen',
                            style: TextStyle(
                                fontFamily: 'FiraSansExtraCondensed',
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  void _showCreateDevice() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: Color.fromRGBO(25, 30, 30, 1.0).withOpacity(0.4),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Text(
                        'Item ändern',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Type:',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        DropdownButton(
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            items: types.keys
                                .map((String key) => DropdownMenuItem(
                                      value: key,
                                      child: Text(key),
                                    ))
                                .toList(),
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (String? newValue) {
                              setState(() {
                                // Muss hier schon gesetzt werden
                                /*
                                    _floors[_floorIndex]
                                        .rooms[_roomIndex]
                                        .devices[_selectedDevice]
                                        .function = newValue!;
                                        */
                                _selectetdType = newValue!;
                                _possibleLabels = _getDeviceItems(newValue!);
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text('Name:',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ),
                        TextField(
                          controller: _deviceNameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: _floors[_floorIndex]
                                .rooms[_roomIndex]
                                .devices[_selectedDevice]
                                .label,
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Icon:',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        ImageIcon(
                            AssetImage(icons[_floors[_floorIndex]
                                    .rooms[_roomIndex]
                                    .devices[_selectedDevice]
                                    .icon]![0] ??
                                'assets/icons/slider.png'), // Device mit Icon
                            size: 50.0,
                            color: Colors.white),
                        DropdownButton(
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            items: icons.keys
                                .map((String key) => DropdownMenuItem(
                                      value: key,
                                      child: Text(key),
                                    ))
                                .toList(),
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (String? newValue) {
                              setState(() {
                                // _selectedIcon = newValue!;
                                // Darf hier noch nicht gesetzt werden
                                _floors[_floorIndex]
                                    .rooms[_roomIndex]
                                    .devices[_selectedDevice]
                                    .icon = newValue!;
                              });
                            })
                      ],
                    ),
                    Row(
                      children: [
                        Text('Zuordnung:',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        DropdownButton(
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            items: _possibleLabels.entries
                                .map((MapEntry device) => DropdownMenuItem(
                                      value: device,
                                      child: Text(device.key),
                                    ))
                                .toList(),
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (MapEntry? newValue) {
                              setState(() {
                                // Muss hier schon gesetzt werden
                                _floors[_floorIndex]
                                    .rooms[_roomIndex]
                                    .devices[_selectedDevice]
                                    .function = newValue!.key;
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.4)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.orangeAccent))),
                          onPressed: () {
                            setState(() {
                              _floors[_floorIndex]
                                  .rooms[_roomIndex]
                                  .devices[_selectedDevice]
                                  .label = _deviceNameController.text;
                              _deviceNameController.clear();
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Speichern',
                            style: TextStyle(
                                fontFamily: 'FiraSansExtraCondensed',
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.4)),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.red))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Abbrechen',
                            style: TextStyle(
                                fontFamily: 'FiraSansExtraCondensed',
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Map<String, List> _getDeviceItems(String type) {
    Map<String, List> items = {};

    _floors.forEach((floor) {
      // element = Floor
      floor.rooms.forEach((room) {
        // element = Room
        room.devices.forEach((device) {
          // element = Device
          if (device.function == type) {
            items[device.item] = [
              device.label,
              device.function,
              room.label,
              floor.name
            ];
          }
        });
      });
    });
    return items;
  }

  /// Get Index of new Room in Floor
  List<int> _getRoomIndex(String roomName) {
    List<int> index = [];
    _floors.forEach((floor) {
      // element = Floor
      floor.rooms.forEach((room) {
        // element = Room
        if (room.label == roomName) {
          index.add(_floors.indexOf(floor));
          index.add(floor.rooms.indexOf(room));
        }
      });
    });
    return index;
  }

  /// Get List of all Rooms
  List<Room> _getRooms() {
    List<Room> rooms = [];
    for (int i = 0; i < _floors.length; i++) {
      for (int j = 0; j < _floors[i].rooms.length; j++) {
        rooms.add(_floors[i].rooms[j]);
      }
    }
    return rooms;
  }

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      _floors[_floorIndex]
          .rooms[_roomIndex]
          .updateDevices(newindex + 1, oldindex + 1);
    });
  }

  Future<bool> _waitForSiteMAp() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  void initState() {
    _isLoading = false;
    _floorIndex = 0;
    _roomIndex = 0;
    _selectedDevice = 0;
    _selectedIcon = '';
    _selectetdType = '';
    _newRoom = '';
    _possibleLabels = {};
    _deviceNameController = TextEditingController();
    _scrollController = ScrollController(
      initialScrollOffset: 200.0,
      keepScrollOffset: true,
    );

    /// setState if _saved is true
    _deviceSaved.addListener(() {
      if (_deviceSaved.value == true) {
        setState(() {
          _deviceSaved.value = false;
          _isLoading = false;
        });
      }
    });

    /// Initiate _floors
    //_floors = _floorDummy;

    OpenhabServices().getSiteMap().then((value) {
      print('InitState: $value');
      setState(() {
        _floors = value;
        _isLoading = false;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _waitForSiteMAp(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.data != true) {
            return const Scaffold(
                body: SafeArea(
                    child: Center(
              child: CircularProgressIndicator(),
            )));
          } else {
            return Scaffold(
                body: SafeArea(
              child: SingleChildScrollView(
                  //physics: const NeverScrollableScrollPhysics(),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            const Header(),
                            const SizedBox(height: 16.0),
                            Responsive(
                              mobile: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: SizedBox(
                                  height: 52,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _floors.length,
                                      itemBuilder: (context, index) {
                                        return _buildFloorElement(
                                            _floors[index].name,
                                            index); //_buildFloorElement('Test');
                                      }),
                                ),
                              ),
                              desktop: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: SizedBox(
                                  height: 52,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _floors.length,
                                      itemBuilder: (context, index) {
                                        return _buildFloorElement(
                                            _floors[index].name,
                                            index); //_buildFloorElement('Test');
                                      }),
                                ),
                              ),
                            ),
                            Responsive(
                              desktop: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 100.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Räume',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: 50.0,
                                          //left: MediaQuery.of(context).size.width * 0.6,
                                        ),
                                        child: _saveButton(context),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              mobile: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text('Räume',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                          )),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: _saveButton(context),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            /// Räume
                            Responsive(
                              mobile: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: SizedBox(
                                    child: ListView.builder(
                                        //controller: _scrollController,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: _floors[_floorIndex]
                                            .rooms
                                            .length, // index ändert sich je nach ausgewähltem Stockwerk
                                        itemBuilder: (context, index) {
                                          return _buildRoomElement(
                                              _floors[_floorIndex].rooms[index],
                                              index);
                                        }),
                                  ),
                                ),
                              ),
                              desktop: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: SizedBox(
                                    child: ListView.builder(
                                        //controller: _scrollController,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            _floors[_floorIndex].rooms.length,
                                        itemBuilder: (context, index) {
                                          return _buildRoomElement(
                                              _floors[_floorIndex].rooms[index],
                                              index);
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
            ));
          }
        });
  }

  Widget _buildFloorElement(String floor, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        height: 52,
        //width: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              _floorIndex = index;
              _roomIndex = 0;
            });
          },
          child: Text(
            floor.substring(1, floor.length - 1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomElement(Room room, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 100.0, right: 100.0, bottom: 10.0),
      child: Column(
        children: [
          Container(
            height: 52,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(children: [
              Center(
                child: SizedBox(
                  height: 52,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _roomIndex = index;
                      });
                    },
                    child: Text(
                      room.label.substring(1, room.label.length - 1),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Image.asset(
                      icons[_floors[_floorIndex].rooms[index].icon]![0] ??
                          'assets/icons/slider.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          _showChangeRoomAttributes(index);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ))),
              )
            ]),
          ),
          if (_roomIndex == index) _buildDeviceBox(room.devices, index),
        ],
      ),
    );
  }

  Widget _buildDeviceBox(List<Device> devices, int index) {
    /// Copy of devices starts at index 1

    List<Device> devicesCopy = devices.sublist(1, devices.length);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: ReorderableListView(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              buildDefaultDragHandles: false,
              shrinkWrap: true,
              children: [
                for (final items in devicesCopy)
                  Card(
                    color: Colors.blueGrey,
                    key: ValueKey(items),
                    elevation: 2,
                    child: TextButton(
                      onPressed: () {
                        // Änderung Name, Icon, etc.
                        _showChangeDeviceAttributes();
                        setState(() {
                          _selectedDevice = devicesCopy.indexOf(items) + 1;
                        });
                      },
                      child: ListTile(
                        trailing: ReorderableDragStartListener(
                          index: devicesCopy.indexOf(items),
                          child: const Icon(Icons.drag_handle),
                        ),
                        title: Text(
                            items.label.substring(1, items.label.length - 1)),
                        leading: Image.asset(icons[items.icon]![0] ??
                            'assets/icons/slider.png'), // Device mit Icon
                        /*color: Colors.white*/
                      ),
                    ),
                  ), //_buildDeviceElement(items.label)
              ],
              onReorder: reorderData,
            )),
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: ElevatedButton(
        onPressed: () {
          // print all of _floors
          _floors.forEach((element) {
            print(element);
          });

          OpenhabServices().saveSiteMap(_floors).then((value) {
            if (value) {
              print('Wert vorhanden');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Sitemap erfolgreich gespeichert'),
                backgroundColor: Colors.green,
              ));
            } else {
              print('Kein Wert vorhanden');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Sitemap konnte nicht gespeichert werden'),
                backgroundColor: Colors.red,
              ));
            }
          });
        },
        child: Text(
          'Speichern',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceElement(String device) {
    return Padding(
      key: ValueKey(device),
      padding: const EdgeInsets.only(
          left: 40.0, right: 0.0, bottom: 10.0, top: 10.0),
      child: Container(
        height: 52,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orangeAccent),
        ),
        child: Center(
          child: Text(
            device,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
