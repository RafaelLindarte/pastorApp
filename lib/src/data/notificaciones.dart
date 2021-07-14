
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:push_notificaction/src/shared/preferences.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


class Notificaciones {

  static FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static Future<void>  _background(RemoteMessage message) async{

          print('_background ${message.messageId}');
          print(message.notification!.android!.sound);
          print(message.data);
          


  }
  static Future<void>  _onbackground(RemoteMessage message) async{

          print('_onBackground ${message.messageId}');
          print(message.data);

  }
  static Future<void>  abirMessage(RemoteMessage message) async{

          print('abrir ${message.messageId}');  
          print(message.data);
          }



  static Future init() async{
    try{

      await Firebase.initializeApp();
    

        final preferences =Preferences();
    
      NotificationSettings  settings = await _messaging.requestPermission(
              sound: true
          );

      AndroidNotificationDetails(
          'chanel',
          'fcm',
          'fcm',
          playSound: true,
          sound: RawResourceAndroidNotificationSound('sonido.mp3'),
          importance: Importance.max,
          priority: Priority.high
      );

              if(settings.authorizationStatus == AuthorizationStatus.authorized){
                print('Autorizado');
              }              
          final token = await _messaging.getToken();
          print(token);
          preferences.token= token;
          FirebaseMessaging.onBackgroundMessage(_background);
          FirebaseMessaging.onMessage.listen(_onbackground,);
          FirebaseMessaging.onMessageOpenedApp.listen(abirMessage);
          


    }catch(e){
      print('aaaaaaaaaaaaaaa');
      print(e);
    }
  }




 
}
 