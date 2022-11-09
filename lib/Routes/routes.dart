const String _os = 'windows'; // kann auch windows oder linux sein

class RoutesName {
  // ignore: non_constant_identifier_names
  static const String HOME_PAGE = '/visu_home_page';
  // ignore: non_constant_identifier_names
  static const String CONFIG_PAGE = '/config_page';
}

class EndPoints {
  Map getEndpoints() {
    if (_os == 'debug') {
      const String UPLOAD_FILE =
          'http://localhost:8080/controller/api/upload.php';
      const String REBOOT = 'http://127.0.0.1/controller/api/reboot.php';
      return {
        'UPLOAD_FILE': UPLOAD_FILE,
        'REBOOT': REBOOT,
      };
    } else {
      const String UPLOAD_FILE = 'controller/api/upload.php';
      const String REBOOT = 'controller/api/reboot.php';
      return {
        'UPLOAD_FILE': UPLOAD_FILE,
        'REBOOT': REBOOT,
      };
    }
  }
}
