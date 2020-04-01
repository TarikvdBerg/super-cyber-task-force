import 'package:steel_crypt/steel_crypt.dart';

// EncryptionManager manages the encryption of strings
class EncryptionManager {

  Encrypter encrypter;

  void setKey(String encKey ){
    this.encrypter = Encrypter(AES(Key.fromUtf8(encKey)));
  }

  // Encrypts a raw string
  String encrypt(String raw) {
    if (this.encrypter == null) {
      throw Exception("Encrypter is not set");
    }

    return this.encrypt(raw);
  }

  // Decrypts a cipher
  String decrypt(String cipher) {
    if (this.encrypter == null) {
      throw Exception("Encrypter is not set");
    }
    
    return this.decrypt(cipher);
  }
}