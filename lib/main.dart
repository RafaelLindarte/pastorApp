// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notificaction/src/data/notificaciones.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
      // await Firebase.initializeApp();  

  await Notificaciones.init();
  runApp(MyApp());
  } 

 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}