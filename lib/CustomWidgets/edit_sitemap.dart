import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visu/Models/models.dart';
import 'package:visu/Responsive/responsive.dart';
import 'package:visu/Services/openhab_service.dart';

class EditSiteMap extends StatefulWidget {
  const EditSiteMap({Key? key}) : super(key: key);

  @override
  State<EditSiteMap> createState() => _EditSiteMapState();
}

class _EditSiteMapState extends State<EditSiteMap> {
  late List<Floor> _floors;
  late bool _isLoading;
  late int _floorIndex;
  late int _roomIndex;
  late int _selectedDevice;
  late String _selectetdType;
  late String _selectedIcon;
  late Map<String, List> _possibleLabels;
  late TextEditingController _deviceNameController;

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

  Map<String, String> icons = {
    'Slider': 'assets/icons/slider.png',
    'Relais': 'assets/icons/relais.png',
    'temperature': 'assets/icons/temperature.png',
  };

  Map<String, String> types = {
    'Schalter': 'Switch',
    'Slider': 'Slider',
    'Messwert': 'Text',
    'Regler': 'Setpoint',
    'Binärsensor': 'Default',
    'Jalousie': 'Default',
  };

  void _showChangeDeviceAttributes() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Dialog(
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
                                _possibleLabels = _getDeviceLabels(newValue!);
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
                                    .icon] ??
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
                            items: _possibleLabels.keys
                                .map((String key) => DropdownMenuItem(
                                      value: key,
                                      child: Text(key),
                                    ))
                                .toList(),
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (String? newValue) {
                              setState(() {
                                // Muss hier schon gesetzt werden
                                _floors[_floorIndex]
                                    .rooms[_roomIndex]
                                    .devices[_selectedDevice]
                                    .function = newValue!;
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
            ));
  }

  Map<String, List> _getDeviceLabels(String type) {
    Map<String, List> labels = {};

    _floors.forEach((floor) {
      // element = Floor
      floor.rooms.forEach((room) {
        // element = Room
        room.devices.forEach((device) {
          // element = Device
          if (device.function == type) {
            labels[device.label] = [room.label, floor.name];
          }
        });
      });
    });
    return labels;
  }

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      _floors[_floorIndex].rooms[_roomIndex].updateDevices(newindex, oldindex);
    });
  }

  @override
  void initState() {
    _isLoading = true;
    _floorIndex = 0;
    _roomIndex = 0;
    _selectedDevice = 0;
    _selectedIcon = '';
    _selectetdType = '';
    _possibleLabels = {};
    _deviceNameController = TextEditingController();
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
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          //physics: const NeverScrollableScrollPhysics(),
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Responsive(
                      mobile: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SizedBox(
                          height: 52,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _floors.length,
                              itemBuilder: (context, index) {
                                return _buildFloorElement(_floors[index].name,
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
                                return _buildFloorElement(_floors[index].name,
                                    index); //_buildFloorElement('Test');
                              }),
                        ),
                      ),
                    ),
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

                    /// Räume
                    Responsive(
                      mobile: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: _floors[_floorIndex]
                                    .rooms
                                    .length, // index ändert sich je nach ausgewähltem Stockwerk
                                itemBuilder: (context, index) {
                                  return _buildRoomElement(
                                      _floors[_floorIndex].rooms[index], index);
                                }),
                          ),
                        ),
                      ),
                      desktop: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: SizedBox(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: _floors[_floorIndex].rooms.length,
                                itemBuilder: (context, index) {
                                  return _buildRoomElement(
                                      _floors[_floorIndex].rooms[index], index);
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
    ));
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
            });
          },
          child: Text(
            floor,
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
            child: TextButton(
              onPressed: () {
                setState(() {
                  _roomIndex = index;
                });
              },
              child: Text(
                room.label,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (_roomIndex == index) _buildDeviceBox(room.devices, index),
        ],
      ),
    );
  }

  Widget _buildDeviceBox(List<Device> devices, int index) {
    /// Hier eine Kopie der Devices erstellen, damit die Reihenfolge verändert werden kann
    List<Device> devicesCopy = devices.toList();
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
                for (final items in devices)
                  Card(
                    color: Colors.blueGrey,
                    key: ValueKey(items),
                    elevation: 2,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Hier die Funktion für die Devices einfügen
                        // Änderung Name, Icon, etc.
                        _showChangeDeviceAttributes();
                        setState(() {
                          _selectedDevice = devices.indexOf(items);
                        });
                      },
                      child: ListTile(
                        trailing: ReorderableDragStartListener(
                          index: devices.indexOf(items),
                          child: const Icon(Icons.drag_handle),
                        ),
                        title: Text(items.label),
                        leading: Icon(
                          Icons.work,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ), //_buildDeviceElement(items.label)
              ],
              onReorder: reorderData,
            )),
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
