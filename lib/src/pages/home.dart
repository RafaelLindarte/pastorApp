
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';
import 'package:push_notificaction/src/data/notificaciones.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:push_notificaction/src/widgets/on_of.dart';



class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> list= [
    'Notificacion1', 
    'Notificacion8', 
    'Notificacion8', 
    'Notificacion9', 
    ];

  @override
  void initState() {
    
    super.initState();
    Notificaciones.messagesStream.listen((event) {       
      Fluttertoast.showToast(msg: 'Recibiste una notificacón');        

      setState(() {
        list.add(event);        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final _notificationProvider = Provider.of<NotificationProvider>(context);
    final _preferences = Preferences();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pastor'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()async{
              await _preferences.clearPreferences();
              Navigator.pushReplacementNamed(context, 'login');

          }, icon: Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,            
            height: MediaQuery.of(context).size.height*0.3,
            child: ElevatedButton(
              child: TextOnOf(), 
              onPressed: () async{                
                    if(_notificationProvider.active){
                        _notificationProvider.isActive = false;
                    }else{
                        _notificationProvider.isActive = true;
                    }              
                  }
            ),
          ),
          Container(          
            alignment: Alignment.center,
            child: Text('Tus Notificaciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          SizedBox(height: 10.0,),
          // Container(
          //   child: FutureBuilder(
          //     builder:(context, snaphsot){
          //       if(snaphsot.hasData){
          //         return Center(child: CircularProgressIndicator());
          //       }else{
          //         return Center(child: Text('listar notificaciones'));
          //       }

          //     }
          //   )
          // )
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, item){

                return _listNotification(list[item]);
              },
              itemCount: list.length,
              ),
          )

        ],
      ),
      
    );
  }


  Widget _listNotification(String item){
    return Card(
      child: Container(
        child: Text(item),
      ),
    );
  }
}