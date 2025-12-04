// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:flutter/foundation.dart';

// class NotificationController with ChangeNotifier {
//   final AudioPlayer player = AudioPlayer();
//   bool isPlaying = false;

//   NotificationController() {
//     _listenForeground();
//   }

//   void _listenForeground() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       playSound();
//     });
//   }
// bool _loading = false;

// Future<void> playSound() async {
//   if (_loading || isPlaying) return; // prevents multiple calls

//   try {
//     _loading = true;
//     print("🎵 Trying to play sound...");

//     // await player.setAsset('assets/clock_alarm.mp3');
//     await player.setAudioSource(AudioSource.asset('assets/sounds/clock.mp3'));

//     await player.play();

//     print("🎵 Sound playing");

//     isPlaying = true;
//     notifyListeners();
//   } catch (e) {
//     print("❌ Sound play error: $e");
//   } finally {
//     _loading = false;
//   }
// }


//   Future<void> stopSound() async {
//     await player.stop();
//     isPlaying = false;
//     notifyListeners();
//   }
// }
