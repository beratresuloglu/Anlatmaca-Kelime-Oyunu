import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> play(String fileName) async {
    await _player.stop();
    
    await _player.play(AssetSource('sounds/$fileName'));
  }

  static Future<void> dispose() async {
    await _player.dispose();
  }
}