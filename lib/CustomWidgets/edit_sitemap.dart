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
  /*
  final List<Room> dummyRooms = [
    Room(label: 'Room 1', icon: 'Icon 1', key: 'Dummy 1'),
    Room(label: 'Room 2', icon: 'Icon 2', key: 'Dummy 2'),
    Room(label: 'Room 3', icon: 'Icon 3', key: 'Dummy 1'),
    Room(label: 'Room 4', icon: 'Icon 4', key: 'Dummy 2'),
    Room(label: 'Room 5', icon: 'Icon 5', key: 'Dummy 1'),
  ];
  final List dummyFloors = [
    'Dummy 1',
    'Dummy 2',
  ];
  final List<Device> dummyDevices = [
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
  final List dummyIcons = [
    'Dummy 1',
    'Dummy 2',
  ];

  Future<Floor> getDummy() async {
    Map<String, dynamic> _dummy = {
      'rooms': dummyRooms,
      'names': dummyFloors,
      'devices': dummyDevices,
      'icons': dummyIcons
    };
    //print(dummy);
    //print(Floor.fromMap(_dummy).names);
    return Floor.fromMap(_dummy);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        //physics: const NeverScrollableScrollPhysics(),
        child: FutureBuilder<Floor>(
            // Floor
            future: OpenhabServices().getSiteMap(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    /// Die Ansicht springt je nach größe automatich auf die richtige Ansicht
                    Responsive(
                      mobile: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SizedBox(
                          height: 52,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.names.length,
                              itemBuilder: (context, index) {
                                return _buildFloorElement(
                                    snapshot.data!.names[index]);
                              }),
                        ),
                      ),
                      desktop: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SizedBox(
                          height: 52,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.names.length,
                              itemBuilder: (context, index) {
                                return _buildFloorElement(
                                    snapshot.data!.names[index]);
                              }),
                        ),
                      ),
                    ),

                    /// Header
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Räume',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 30,
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
                                itemCount: snapshot.data!.rooms.length,
                                itemBuilder: (context, index) {
                                  return _buildRoomElement(
                                    snapshot.data!.rooms[index].label,
                                    snapshot.data!.devices,
                                  );
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
                                itemCount: snapshot.data!.rooms.length,
                                itemBuilder: (context, index) {
                                  return _buildRoomElement(
                                    snapshot.data!.rooms[index].label,
                                    snapshot.data!.devices,
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ));
  }

  Widget _buildFloorElement(String floor) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.03,
      width: MediaQuery.of(context).size.width * 0.1,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          //const Icon(Icons.home, size: 50, color: Colors.white),
          Text(
            floor,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomElement(String room, List<Device> devices) {
    return Padding(
      padding: const EdgeInsets.only(left: 120.0, right: 120.0, bottom: 10.0),
      child: Column(
        children: [
          Container(
            height: 52,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                room,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _buildDeviceBox(devices, room)
        ],
      ),
    );
  }

  Widget _buildDeviceBox(List<Device> devices, String room) {
    List<Device> _devices = [];
    for (var i = 0; i < devices.length; i++) {
      if (devices[i].key == room) {
        _devices.add(devices[i]);
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                return _buildDeviceElement(_devices[index].label);
              }),
        ),
      ),
    );
  }

  Widget _buildDeviceElement(String device) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
      child: Container(
        height: 52,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orangeAccent),
        ),
        child: Text(
          device,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
