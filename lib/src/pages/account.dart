import 'package:flutter/material.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:push_notificaction/src/style/theme.dart';

class AcountPage extends StatefulWidget {
  AcountPage({Key? key}) : super(key: key);

  @override
  _AcountPageState createState() => _AcountPageState();
}

class _AcountPageState extends State<AcountPage> {
  final themeData = StyleData();
  final preferences = Preferences();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.red.withOpacity(0.9),
              title: Text('Tu Cuenta'),
              actions: [
                IconButton(onPressed: () {
                  preferences.clearPreferences();
                  Navigator.pushNamed(context, 'login');
                }, icon: Icon(Icons.exit_to_app))
              ],
            ),
            body: Stack(
              children: [
                Container(
                  color: Colors.grey.withOpacity(0.16),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, right: 30, left:30),
                  child: Column(children: [
                    Card(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              color: Colors.grey.withOpacity(0.1),
                              alignment: Alignment.centerLeft,
                              child:Text(' Datos Personales', style: TextStyle(fontSize:16, fontWeight:FontWeight.bold))
                            ),
                            Container(
                              decoration: themeData.decorationInputs(0.0),
                              child: TextField(
                                // onChanged: (e)=>emaill = e,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    themeData.inputDecoration(' Nombre', true),
                              ),
                            ),
                            Container(
                              decoration: themeData.decorationInputs(0.0),
                              child: TextField(
                                // onChanged: (e)=>emaill = e,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    themeData.inputDecoration(' Apellido', true),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(                  
                    color: Colors.grey.withOpacity(0.1),
                      child: Card(
                        child: Column(children: [
                           Container(
                              color: Colors.grey.withOpacity(0.1),
                              alignment: Alignment.centerLeft,
                              child:Text(' Tus subscripciones', style: TextStyle(fontSize:16, fontWeight:FontWeight.bold))
                            ),
                            SizedBox(height: 3,),
                              Container(
                              color: Colors.grey.withOpacity(0.1),
                              alignment: Alignment.centerLeft,
                              child:Text(' Tus subscripciones', style: TextStyle(fontSize:16, fontWeight:FontWeight.bold))
                            ),
                            
                              Container(
                              color: Colors.grey.withOpacity(0.1),
                              alignment: Alignment.centerLeft,
                              child:Text(' Tus subscripciones', style: TextStyle(fontSize:16, fontWeight:FontWeight.bold))
                            ),
                            
                              Container(
                              color: Colors.grey.withOpacity(0.1),
                              alignment: Alignment.centerLeft,
                              child:Text(' Tus subscripciones', style: TextStyle(fontSize:16, fontWeight:FontWeight.bold))
                            ),

                        ],),
                      ),
                    )
                  ]),
                )
              ],
            )));
  }
}


