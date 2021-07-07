




import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notificaciones {



  static FirebaseMessaging messaging = FirebaseMessaging.instance;



  static Future init() async{

    try{
      await Firebase.initializeApp();  
          final token = await messaging.getToken();
          print(token);
    }catch(e){
      print('aaaaaaaaaaaaaaa');
      print(e);
    }
  }
}