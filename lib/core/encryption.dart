import 'dart:typed_data';

import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/api.dart' hide SecureRandom;
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:encrypt/encrypt.dart';

// EncryptionManager manages the encryption of strings
class EncryptionManager {
  Encrypter _encrypter;

  void setKey(String encKey, {int iterationCount: 100100}) {
    // desired key length = 256/8 = 32 bytes for AES key
    final int desiredKeyLength = 32;
    final Uint8List salt = SecureRandom(desiredKeyLength).bytes;
    final Pbkdf2Parameters params = Pbkdf2Parameters(
      salt,
      iterationCount,
      desiredKeyLength,
    );
    final PBKDF2KeyDerivator derivator = PBKDF2KeyDerivator(Mac('SHA-256/HMAC'))..init(params);
    final Key key = Key(derivator.process(Key.fromUtf8(encKey).bytes));

    _encrypter = Encrypter(
      AES(
        key,
        mode: AESMode.cbc,
        padding: null,
      ),
    );
  }

  // Encrypts a raw string
  String encrypt(String raw) {
    if (_encrypter == null) {
      throw Exception("Encrypter is not set");
    }

    return _encrypter.encrypt(raw, iv: IV.fromLength(16)).base64;
  }

  // Decrypts a cipher
  String decrypt(String base64) {
    if (_encrypter == null) {
      throw Exception("Encrypter is not set");
    }

    return _encrypter.decrypt(Encrypted.fromBase64(base64),
        iv: IV.fromLength(16));
  }
}
