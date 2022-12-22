const String _os = 'debug'; // kann auch windows oder linux sein

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
          'http://192.168.1.228:80/build/web/controller/api/upload.php';
      const String REBOOT =
          'http://192.168.1.228:80/build/web/controller/api/reboot.php';
      const String SAVE =
          'http://192.168.1.228:80/build/web/controller/api/save.php';
      const String LOAD =
          'http://192.168.1.228:80/build/web/controller/api/load.php';
      const String PCHK_CONFIG =
          'http://192.168.1.228:80/build/web/controller/api/config.php';
      return {
        'UPLOAD_FILE': UPLOAD_FILE,
        'REBOOT': REBOOT,
        'SAVE': SAVE,
        'LOAD': LOAD,
        'PCHK_CONFIG': PCHK_CONFIG,
      };
    } else {
      const String UPLOAD_FILE = 'controller/api/upload.php';
      const String REBOOT = 'controller/api/reboot.php';
      const String SAVE = 'controller/api/save.php';
      const String LOAD = 'controller/api/load.php';
      const String PCHK_CONFIG = 'controller/api/config.php';
      return {
        'UPLOAD_FILE': UPLOAD_FILE,
        'REBOOT': REBOOT,
        'SAVE': SAVE,
        'LOAD': LOAD,
        'PCHK_CONFIG': PCHK_CONFIG,
      };
    }
  }
}
