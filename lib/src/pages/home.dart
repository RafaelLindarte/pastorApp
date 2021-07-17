import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';
import 'package:push_notificaction/src/data/notificaciones.dart';
import 'package:push_notificaction/src/data/provider/user-provider.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:push_notificaction/src/style/theme.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = ['Sismica','Forestal','Tormenta Tropical'];
  final d = {
    "evento":[
      {
        "name":"Sismca",
        "status":true,
      },
      {
        "name":"Forestal",
        "status":true,
      },
      {
        "name":"Tormenta tropical",
        "status":true,
      },  
       ]
  };
  bool status = true;  


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
    final _preferences = Preferences();
  List<dynamic>  dd = d['evento']!.toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.withOpacity(0.9),
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
              print(dd);
              return _cardEstaciones( dd[index]);
            },
            itemCount:dd.length,
          ),
        ),
             ),
    );
  }
  Widget _cardEstaciones(dynamic data){      
final styleData = StyleData();
final _notificationProvider = Provider.of<NotificationProvider>(context);
final userProvider = USerProvider();

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
                                onPressed: () async {
                                  await userProvider.onOf();     

                                  // if(data['status']==false){
                                    setState(() {
                                      data['status'] = !data['status'];
                                     });

                                        print(d['evento']);
                                  // }
                                  //    if(_notificationProvider.active){
                                  //     _notificationProvider.isActive = false;
                                  // }else{
                                  //     _notificationProvider.isActive = true;
                                  // }                                
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.powerOff,
                                   color: (data['status']) ? Colors.green: Colors.red,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                             //sismica
      // tormenta tropical
      //forestal
                          child: Text(
                            '${data['name']}',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    )
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, 'notifications');
                    },
              );


  }

}
