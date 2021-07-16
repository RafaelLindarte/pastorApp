import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';
import 'package:push_notificaction/src/data/notificaciones.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = [
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
        backgroundColor: Colors.orangeAccent.withOpacity(0.9),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  _preferences.clearPreferences();
                  Navigator.pushNamed(context, 'login');
                  Fluttertoast.showToast(msg: 'Salir de la cuenta');
                }, icon: Icon(Icons.account_circle_sharp)),
            Text('Pastor'),
            IconButton(onPressed: () {
              Fluttertoast.showToast(msg: 'Agregar estación');
            }, icon: Icon(Icons.add)),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.16),
        padding: EdgeInsets.only(top: 30),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.water,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {
                                Fluttertoast.showToast(msg: 'On/Off notificaciones');
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.powerOff,
                                color: Colors.green,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          'Fluvial',
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  )
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, 'notifications');
                  },
            );
          },
          itemCount: 6,
        ),
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       alignment: Alignment.center,
      //       height: MediaQuery.of(context).size.height*0.3,
      //       child: ElevatedButton(
      //         child: TextOnOf(),
      //         onPressed: () async{
      //               if(_notificationProvider.active){
      //                   _notificationProvider.isActive = false;
      //               }else{
      //                   _notificationProvider.isActive = true;
      //               }
      //             }
      //       ),
      //     ),
      //     Container(
      //       alignment: Alignment.center,
      //       child: Text('Tus Notificaciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
      //     SizedBox(height: 10.0,),
      //     // Container(
      //     //   child: FutureBuilder(
      //     //     builder:(context, snaphsot){
      //     //       if(snaphsot.hasData){
      //     //         return Center(child: CircularProgressIndicator());
      //     //       }else{
      //     //         return Center(child: Text('listar notificaciones'));
      //     //       }

      //     //     }
      //     //   )
      //     // )
      //     Container(
      //       height: MediaQuery.of(context).size.height*0.3,
      //       child: ListView.builder(
      //         shrinkWrap: true,
      //         itemBuilder: (context, item){

      //           return _listNotification(list[item]);
      //         },
      //         itemCount: list.length,
      //         ),
      //     )

      //   ],
      // ),
    );
  }

  Widget _listNotification(String item) {
    return Card(
      child: Container(
        child: Text(item),
      ),
    );
  }
}
