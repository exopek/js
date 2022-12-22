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
  String licence;
  String licence_count;
  bool active_wlan_hotspot;
  String pchk_password;

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
      required this.current_region,
      required this.licence,
      required this.licence_count,
      required this.active_wlan_hotspot,
      required this.pchk_password});

  factory Pchkconfig.fromJson(json) {
    return Pchkconfig(
        status: json['status'] ?? false,
        message: json['message'] ?? '',
        version: json['version'] ?? '',
        pchk_version: json['pchk_version'] ?? '',
        pchk_host_id: json['pchk_host_id'] ?? '',
        pchk_timeout_std: json['pchk_timeout_std'] ?? 0,
        pchk_timeout_min: json['pchk_timeout_min'] ?? 0,
        interface_state: json['interface_state'] ?? '',
        interface_ip: json['interface_ip'] ?? [],
        interface_subnet: json['interface_subnet'] ?? [],
        interface_gateway: json['interface_gateway'] ?? [],
        interface_dns: json['interface_dns'] ?? [],
        host_name: json['host_name'] ?? '',
        user_name: json['user_name'] ?? '',
        syncTime: json['syncTime'] ?? '',
        syncTimeLink: json['syncTimeLink'] ?? '',
        pke_mode: json['pke_mode'] ?? '',
        dhcp_status: json['dhcp_status'] ?? '',
        wifi_status: json['wifi_status'] ?? '',
        wifi_automatic: json['wifi_automatic'] ?? '',
        timezones: json['timezones'] ?? {},
        current_timezone: json['current_timezone'] ?? '',
        current_region: json['current_region'] ?? '',
        licence: json['licence'] ?? '',
        licence_count: json['licence_count'] ?? '',
        active_wlan_hotspot: json['active_wlan_hotspot'] ?? false,
        pchk_password: '');
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
        'licence': licence,
        'licence_count': licence_count,
        'active_wlan_hotspot': active_wlan_hotspot,
        'pchk_password': pchk_password
      };
}

class PchkPostConfig {
  final String? save_settings;
  final String? username_new;
  final String? passwd_new;
  final String? passwd_repeat;
  final String? passwd_old;
  final int? pchk_timeout_std;
  final int? pchk_timeout_min;
  final String? pchk_modid;
  final String? ip_1;
  final String? ip_2;
  final String? ip_3;
  final String? ip_4;
  final String? subnet_1;
  final String? subnet_2;
  final String? subnet_3;
  final String? subnet_4;
  final String? gw_1;
  final String? gw_2;
  final String? gw_3;
  final String? gw_4;
  final String? dns_1;
  final String? dns_2;
  final String? dns_3;
  final String? dns_4;
  final String? enable_dhcp;
  final String? current_ip;
  final String? current_subnet;
  final String? current_gw;
  final String? current_dns;
  final String? current_hostname;
  final String? hostname;
  final String? wifi_ip_1;
  final String? wifi_ip_2;
  final String? wifi_ip_3;
  final String? wifi_ip_4;
  final String? enable_wireless;
  final String? current_wifi_ip;
  final String? wifi_wpa_key;
  final String? current_wifi_wpa_key;
  final String? enable_automatic;
  final String? date;
  final String? time;
  final String? tzone;
  final String? current_date;
  final String? current_time;
  final String? current_tzone;
  final String? enable_rtc_sync;
  final String? get_time_from_ntp;
  final String? ntp_server;

  PchkPostConfig({
    this.save_settings,
    this.username_new,
    this.passwd_new,
    this.passwd_repeat,
    this.passwd_old,
    this.pchk_timeout_std,
    this.pchk_timeout_min,
    this.pchk_modid,
    this.ip_1,
    this.ip_2,
    this.ip_3,
    this.ip_4,
    this.subnet_1,
    this.subnet_2,
    this.subnet_3,
    this.subnet_4,
    this.gw_1,
    this.gw_2,
    this.gw_3,
    this.gw_4,
    this.dns_1,
    this.dns_2,
    this.dns_3,
    this.dns_4,
    this.enable_dhcp,
    this.current_ip,
    this.current_subnet,
    this.current_gw,
    this.current_dns,
    this.current_hostname,
    this.hostname,
    this.wifi_ip_1,
    this.wifi_ip_2,
    this.wifi_ip_3,
    this.wifi_ip_4,
    this.enable_wireless,
    this.current_wifi_ip,
    this.wifi_wpa_key,
    this.current_wifi_wpa_key,
    this.enable_automatic,
    this.date,
    this.time,
    this.tzone,
    this.current_date,
    this.current_time,
    this.current_tzone,
    this.enable_rtc_sync,
    this.get_time_from_ntp,
    this.ntp_server,
  });

  Map<String, dynamic> toJson() => {
        'save_settings': save_settings ?? '',
        'username_new': username_new ?? '',
        'password_new': passwd_new ?? '',
        'password_new_repeat': passwd_repeat ?? '',
        'password_old': passwd_old ?? '',
        'pchk_timeout_std': pchk_timeout_std ?? '',
        'pchk_timeout_min': pchk_timeout_min ?? '',
        'pchk_modid': pchk_modid ?? '',
        'ip_1': ip_1 ?? '',
        'ip_2': ip_2 ?? '',
        'ip_3': ip_3 ?? '',
        'ip_4': ip_4 ?? '',
        'subnet_1': subnet_1 ?? '',
        'subnet_2': subnet_2 ?? '',
        'subnet_3': subnet_3 ?? '',
        'subnet_4': subnet_4 ?? '',
        'gateway_1': gw_1 ?? '',
        'gateway_2': gw_2 ?? '',
        'gateway_3': gw_3 ?? '',
        'gateway_4': gw_4 ?? '',
        'dns_1': dns_1 ?? '',
        'dns_2': dns_2 ?? '',
        'dns_3': dns_3 ?? '',
        'dns_4': dns_4 ?? '',
        'enable_dhcp': enable_dhcp ?? '',
        'current_ip': current_ip ?? '',
        'current_subnet': current_subnet ?? '',
        'current_gateway': current_gw ?? '',
        'current_dns': current_dns ?? '',
        'current_hostname': current_hostname ?? '',
        'hostname': hostname ?? '',
        'wifi_ip_1': wifi_ip_1 ?? '',
        'wifi_ip_2': wifi_ip_2 ?? '',
        'wifi_ip_3': wifi_ip_3 ?? '',
        'wifi_ip_4': wifi_ip_4 ?? '',
        'enable_wireless': enable_wireless ?? '',
        'current_wifi_ip': current_wifi_ip ?? '',
        'wifi_wpa_key': wifi_wpa_key ?? '',
        'current_wifi_wpa_key': current_wifi_wpa_key ?? '',
        'enable_automatic': enable_automatic ?? '',
        'date': date ?? '',
        'time': time ?? '',
        'tzone': tzone ?? '',
        'current_date': current_date ?? '',
        'current_time': current_time ?? '',
        'current_tzone': current_tzone ?? '',
        'enable_rtc_sync': enable_rtc_sync ?? '',
        'get_time_from_ntp': get_time_from_ntp ?? '',
        'ntp_server': ntp_server ?? '',
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
