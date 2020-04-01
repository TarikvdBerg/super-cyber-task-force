import 'package:steel_crypt/steel_crypt.dart';

  pbkdf12(salt, pass) {
    var passHash = PassCrypt('SHA-256/HMAC/PBKDF2');
    var hash = passHash.hashPass(salt, pass, 32);
    return hash;
  }

