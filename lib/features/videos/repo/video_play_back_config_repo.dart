import 'package:shared_preferences/shared_preferences.dart';

/// Repository for red & save data only
class PlaybackConfigRepository {
  static const String _muted = "muted";
  static const String _autoplay = "autoplay";

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  /// Save data
  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  /// Read data
  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}