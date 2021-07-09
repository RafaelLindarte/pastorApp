
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notificaction/src/shared/preferences.dart';



class Notificaciones {

  static FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static Future<void>  _background(RemoteMessage message) async{

          print('_background ${message.messageId}');

  }
  static Future<void>  _onbackground(RemoteMessage message) async{

          print('_onBackground ${message.messageId}');

  }
  static Future<void>  abirMessage(RemoteMessage message) async{

          print('abrir ${message.messageId}');  }



  static Future init() async{
    try{

      await Firebase.initializeApp();
        final preferences =Preferences();

      

          final token = await _messaging.getToken();
          print(token);
          preferences.token= token;
          FirebaseMessaging.onBackgroundMessage(_background);
          FirebaseMessaging.onMessage.listen(_onbackground);
          FirebaseMessaging.onMessageOpenedApp.listen(abirMessage);




    }catch(e){
      print('aaaaaaaaaaaaaaa');
      print(e);
    }
  }
}