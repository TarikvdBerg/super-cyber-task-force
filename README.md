# SCTF Password Manager

## Developers
* Axel Valent
* Roy van Bragt
* Tarik van den Berg
* Yoran Vulker
* Niels van Marion

## Client
The client is based on the flutter desktop sdk and completely written in Dart

### Development
To start development for the client you'll need to have flutter installed: https://flutter.dev/docs/get-started/install. You <b>don't</b> need to setup the android the android sdk if you are just developing for desktop.

By default, the flutter desktop development is not enabled. The following steps will allow you to set this up:

1. Switch flutter to latest release and upgrade it: 
```
flutter channel master
flutter upgrade
```
2. Tell flutter that you want to enable desktop development
```bash
# Windows
flutter config --enable-windows-desktop

# Linux
flutter config --enable-linux-desktop

# MacOS
flutter config --enable-macos-desktop
```

3. Once enabled, run `flutter doctor` see what additional dependencies need to be installed on your platform. Make sure to install the version specified by `flutter doctor` otherwise they won't be detected.