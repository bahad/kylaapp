// ignore_for_file: non_constant_identifier_names
class AssetManager {
  static AssetManager? _instance;
  static AssetManager get instance {
    _instance ??= AssetManager._init();
    return _instance!;
  }

  AssetManager._init();
  String get splash_image => "assets/images/splash.jpeg";
  String get google => "assets/images/google.png";
  String get home_banner => "assets/images/home_banner.png";
  String get avatar => "assets/images/avatar.jpeg";
}
