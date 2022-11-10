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
  final List<String> names;
  final List<String> icons;
  final List<Room> rooms;
  final List<Device> devices;

  Floor(this.names, this.icons, this.rooms, this.devices);

  Floor.fromMap(Map<String, dynamic> map)
      : names = map['names'],
        icons = map['icons'],
        rooms = map['rooms'],
        devices = map['devices'];

  Map<String, dynamic> toMap() => {
        'names': names,
        'icons': icons,
        'rooms': rooms,
        'devices': devices,
      };
}

class Room {
  final String label;
  final String icon;
  final String key;

  Room({required this.label, required this.icon, required this.key});

  Map<String, dynamic> toMap() {
    return {'label': label, 'icon': icon, 'key': key};
  }

  factory Room.clear() {
    return Room(
      label: '',
      icon: '',
      key: '',
    );
  }
}

class Device {
  final String label;
  final String? icon;
  final String item;
  final String? step;
  final String function;
  final String key;

  Device(
      {required this.label,
      required this.item,
      this.icon,
      this.step,
      required this.key,
      required this.function});

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
