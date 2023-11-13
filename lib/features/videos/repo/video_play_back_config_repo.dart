import 'package:shared_preferences/shared_preferences.dart';

/// Repository for red & save data only
class VideoPlaybackConfigRepository {
  static const String _muted = "muted";
  static const String _autoplay = "autoplay";

  final SharedPreferences _preferences;

  VideoPlaybackConfigRepository(this._preferences);

  /// Save data
  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  /// Read data
  bool _isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool _isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}