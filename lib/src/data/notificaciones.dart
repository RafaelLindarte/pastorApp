
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notificaciones {



  static FirebaseMessaging _messaging = FirebaseMessaging.instance;
 
  static Future<void>  _background(RemoteMessage message) async{

          print(message.messageId);
    
  }
  static Future<void>  _onbackground(RemoteMessage message) async{

          print(message.messageId);
    
  }
  static Future<void>  abirMessage(RemoteMessage message) async{

          print(message.messageId);
    
  }


  static Future init() async{
    try{
      await Firebase.initializeApp();  
          final token = await _messaging.getToken();
          print(token);     

          FirebaseMessaging.onBackgroundMessage(_background);
          FirebaseMessaging.onMessage.listen(_onbackground);
          FirebaseMessaging.onMessageOpenedApp.listen(abirMessage);


          
           
    }catch(e){
      print('aaaaaaaaaaaaaaa');
      print(e);
    }
  }
}