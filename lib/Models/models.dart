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
