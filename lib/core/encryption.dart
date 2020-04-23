import 'dart:convert';
import 'dart:typed_data';

import 'package:steel_crypt/PointyCastleN/export.dart';
import 'package:steel_crypt/steel_crypt.dart';

// EncryptionManager manages the encryption of strings
class EncryptionManager {
  static final String _keyAlgorithm = "SHA-256/HMAC/PBKDF2";
  AesCrypt _encrypter;

  String hash(String password, String salt, {int iterationCount: 100100}) {
    // create key derivator for key algorithm SHA-256/HMAC/PBKDF2
    KeyDerivator derivator = KeyDerivator(_keyAlgorithm);
    Pbkdf2Parameters params = Pbkdf2Parameters(
      Uint8List.fromList(salt.codeUnits),
      100100,
      32,
    );
    derivator.init(params);
    var bytes = Uint8List.fromList(utf8.encode(password));
    var key = derivator.process(bytes);
    return String.fromCharCodes(key);
  }

  String setKey(String key) {
    _encrypter = AesCrypt(
      key,
      'cbc',
      'iso10126-2',
    );
  }

  // Encrypts a raw string
  String encrypt(String raw) {
    if (_encrypter == null) {
      throw Exception("Encrypter is not set");
    }

    return _encrypter.encrypt(raw, '0000000000000000');
  }

  // Decrypts a cipher
  String decrypt(String ciphertext) {
    if (_encrypter == null) {
      throw Exception("Encrypter is not set");
    }

    return _encrypter.decrypt(ciphertext, '0000000000000000');
  }
}
