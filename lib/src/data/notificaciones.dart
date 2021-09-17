import 'dart:async';

//import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notificaction/src/shared/preferences.dart';

class Notificaciones {
  static FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static StreamController<String> _messageStreamController =
      StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStreamController.stream;
  static Future<void> _background(RemoteMessage message) async {
    final player = AudioCache();
    // // call this method when desired
    await player.play('sound/sonido.mp3');

    _messageStreamController.add(message.notification?.title ?? 'no titulo');
  }

  static Future<void> _onbackground(RemoteMessage message) async {
    final player = AudioCache();

    // call this method when desired
    await player.play('sound/sonido.mp3');
    _messageStreamController.add(message.notification?.title ?? 'no titulo');
  }

  static Future<void> abirMessage(RemoteMessage message) async {
    final player = AudioCache();
    // call this method when desired
    await player.play('sound/sonido.mp3');
    _messageStreamController.add(message.notification?.title ?? 'no titulo');
  }

  static Future init() async {
    try {
      await Firebase.initializeApp();
      final preferences = Preferences();

      await _messaging.requestPermission(sound: false);
      final token = await _messaging.getToken();
      preferences.token = token;
      FirebaseMessaging.onBackgroundMessage(_background);
      FirebaseMessaging.onMessage.listen(
        _onbackground,
      );
      FirebaseMessaging.onMessageOpenedApp.listen(abirMessage);
    } catch (e) {
      print(e);
    }
  }

  static dispose() {
    _messageStreamController.close();
  }
}
