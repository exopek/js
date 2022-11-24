class Auth {
  final String user;
  final String pass;
  final String message;
  final bool error;
  final bool success;

  Auth(this.user, this.pass, this.message, this.error, this.success);

  Auth.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        pass = json['pass'],
        message = json['message'],
        error = json['error'],
        success = json['success'];

  Map<String, dynamic> toJson() => {
        'user': user,
        'pass': pass,
        'message': message,
        'error': error,
        'success': success,
      };
}

class UploadFile {
  final String name;
  final String date;
  final String time;
  final bool error;
  final bool success;

  UploadFile(this.name, this.date, this.time, this.error, this.success);

  UploadFile.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = json['date'],
        time = json['time'],
        error = json['error'],
        success = json['success'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'date': date,
        'time': time,
        'error': error,
        'success': success,
      };
}

class ParserResponse {
  final bool status;
  final String message;
  final String modules;
  final String rooms;
  final String devices;

  ParserResponse(
      this.status, this.message, this.modules, this.rooms, this.devices);

  ParserResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        modules = json['modules'],
        rooms = json['rooms'],
        devices = json['devices'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'modules': modules,
        'rooms': rooms,
        'devices': devices,
      };
}

class Floor {
  final String name;
  final String icon;
  List<Room> rooms;

  Floor({required this.name, required this.icon, required this.rooms});

  Floor.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        icon = map['icon'],
        rooms = map['rooms'];

  Map<String, dynamic> toMap() => {
        'names': name,
        'icons': icon,
        'rooms': rooms,
      };

  updateRooms(List<Room> rooms) {
    this.rooms = rooms;
  }
}

class Room {
  String label;
  String icon;
  final String key;
  List<Device> devices;

  Room(
      {required this.label,
      required this.icon,
      required this.key,
      required this.devices});

  Map<String, dynamic> toMap() {
    return {'label': label, 'icon': icon, 'key': key, 'devices': devices};
  }

  updateDevices(int newIndex, int oldIndex) {
    List<Device> temp = [];
    Device tempDevice = devices[oldIndex];
    devices.removeAt(oldIndex);

    /// Update the device at the given index
    for (int i = 0; i < devices.length + 1; i++) {
      if (i < newIndex) {
        temp.add(devices[i]); // Copy Value to temp
      } else if (i == newIndex) {
        temp.add(tempDevice);
      } else {
        temp.add(devices[i - 1]);
      }
    }
    devices = temp.toList();
    temp = [];
  }

  factory Room.clear() {
    return Room(
      label: '',
      icon: '',
      key: '',
      devices: [],
    );
  }
}

class Device {
  String label;
  String? icon;
  final String item;
  String? step;
  String function;
  String key;

  Device(
      {required this.label,
      required this.item,
      this.icon,
      this.step,
      required this.key,
      required this.function});

  updateIcon(String icon) {
    this.icon = icon;
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'item': item,
      'icon': icon,
      'step': step,
      'key': key,
      'function': function
    };
  }

  factory Device.clear() {
    return Device(
        label: '', item: '', icon: '', step: '', function: '', key: '');
  }
}

class Pchkconfig {
  bool status;
  String message;
  String version; // String
  String pchk_version; // String
  String pchk_host_id; // String
  int pchk_timeout_std; // int
  int pchk_timeout_min; // int
  String interface_state; // String "UP" or "DOWN"
  List interface_ip;
  List interface_subnet;
  List interface_gateway;
  List interface_dns;
  String host_name; // String
  String user_name; // String
  String syncTime; // String
  String syncTimeLink;
  String pke_mode; // String "0", "pke_mode_private"
  String dhcp_status; // String "true", "false"
  String wifi_status; // String "true", "false"
  String wifi_automatic; // String "true", "false"
  Map<String, dynamic> timezones; // List
  String current_timezone; // Wichtig als Voreinstellung
  String current_region; // Wichtig als Voreinstellung

  Pchkconfig(
      {required this.status,
      required this.message,
      required this.version,
      required this.wifi_status,
      required this.wifi_automatic,
      required this.pchk_version,
      required this.pchk_host_id,
      required this.pchk_timeout_std,
      required this.pchk_timeout_min,
      required this.interface_state,
      required this.interface_ip,
      required this.interface_subnet,
      required this.interface_gateway,
      required this.interface_dns,
      required this.host_name,
      required this.user_name,
      required this.syncTime,
      required this.syncTimeLink,
      required this.pke_mode,
      required this.dhcp_status,
      required this.timezones,
      required this.current_timezone,
      required this.current_region});

  factory Pchkconfig.fromJson(json) {
    return Pchkconfig(
        status: json['status'],
        message: json['message'],
        version: json['version'],
        pchk_version: json['pchk_version'],
        pchk_host_id: json['pchk_host_id'],
        pchk_timeout_std: json['pchk_timeout_std'],
        pchk_timeout_min: json['pchk_timeout_min'],
        interface_state: json['interface_state'],
        interface_ip: json['interface_ip'],
        interface_subnet: json['interface_subnet'],
        interface_gateway: json['interface_gateway'],
        interface_dns: json['interface_dns'],
        host_name: json['host_name'],
        user_name: json['user_name'],
        syncTime: json['syncTime'],
        syncTimeLink: json['syncTimeLink'],
        pke_mode: json['pke_mode'],
        dhcp_status: json['dhcp_status'],
        wifi_status: json['wifi_status'],
        wifi_automatic: json['wifi_automatic'],
        timezones: json['timezones'],
        current_timezone: json['current_timezone'],
        current_region: json['current_region']);
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'version': version,
        'pchk_version': pchk_version,
        'pchk_host_id': pchk_host_id,
        'pchk_timeout_std': pchk_timeout_std,
        'pchk_timeout_min': pchk_timeout_min,
        'interface_state': interface_state,
        'interface_ip': interface_ip,
        'interface_subnet': interface_subnet,
        'interface_gateway': interface_gateway,
        'interface_dns': interface_dns,
        'host_name': host_name,
        'user_name': user_name,
        'syncTime': syncTime,
        'syncTimeLink': syncTimeLink,
        'pke_mode': pke_mode,
        'dhcp_status': dhcp_status,
        'wifi_status': wifi_status,
        'wifi_automatic': wifi_automatic,
        'timezones': timezones,
        'current_timezone': current_timezone,
        'current_region': current_region,
      };
}

class SiteMap {
  final Map<String, dynamic> floors;
  final Map<String, dynamic> rooms;
  final Map<String, dynamic> devices;

  SiteMap({required this.floors, required this.rooms, required this.devices});

  factory SiteMap.fromJson(siteMap) {
    // Parsen der SiteMap

    return SiteMap(
      floors: siteMap['floors'],
      rooms: siteMap['rooms'],
      devices: siteMap['devices'],
    );
  }
}
