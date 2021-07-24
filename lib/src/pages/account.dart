import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/model/modelo-tarjetas-alertas.dart';
import 'package:push_notificaction/src/data/model/user-model.dart';
import 'package:push_notificaction/src/data/provider/user-provider.dart';
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
  bool isEditName = false;
  bool isEditLastName = false;
  String _firstName = '';
  String _lastName = '';
  final userProvider = USerProvider();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.red.withOpacity(0.9),
              title: Text('Tu Cuenta'),
              actions: [
                IconButton(
                    onPressed: () {
                      preferences.clearPreferences();
                      Navigator.pushNamed(context, 'login');
                    },
                    icon: Icon(Icons.exit_to_app))
              ],
            ),
            body: Stack(
              children: [
                Container(
                  color: Colors.grey.withOpacity(0.16),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, right: 30, left: 30),
                  child: SingleChildScrollView(
                    child: Column(children: [
                        Container(
                                  alignment: Alignment.center,
                                  child: Text(' Datos Personales',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))),
                      Card(
                        child: Column(
                            children: [                            
                              Container(
                                child: FutureBuilder(
                                    future: userProvider.getUser(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<User> snapshot) {
                                      User? data = snapshot.data;
                                      if (!snapshot.hasData) {
                                        return Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: CupertinoActivityIndicator());
                                      } else {
                                        return _datosPersonales(data!);
                                      }
                                    }),
                              ),
                            ],
                          ),
                        
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text(' Tus subscripciones',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        child: Card(
                          child: SingleChildScrollView(
                            child:
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: 
                                          Container(
                                                child: FutureBuilder(
                                                    future: userProvider
                                                        .getAllAlertByUserId(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot snapshot) {
                                                      List<AlertModel> list =
                                                          snapshot.data ?? [];
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                            alignment:
                                                                Alignment.center,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 20),
                                                            child:
                                                                CupertinoActivityIndicator());
                                                      } else {
                                                        return ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: list.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int item) {
                                                              return subscripciones( list[item], context);
                                                            });
                                                      }
                                                    })
                                                    ),                                        
                                
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                )
              ],
            )));
  }

  Widget _datosPersonales(User data) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5),
            // decoration: themeData.decorationInputs(0.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: data.firstName ?? '',
                    onChanged: (e) => _firstName = e,
                    enabled: isEditName,
                    keyboardType: TextInputType.emailAddress,
                    decoration: themeData.inputDecoration(' Nombre', false),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      isEditName = !isEditName;
                      setState(() {});
                      if (!isEditName) {
                        final data =
                            await userProvider.updateName(_firstName.trim());
                        if (data == 'ok') {
                          Fluttertoast.showToast(
                              msg: 'Nombre actualizado con exito');
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Error, intente nuevamente');
                        }
                      }
                    },
                    icon: (!isEditName)
                        ? Icon(Icons.edit)
                        : Icon(
                            Icons.check,
                            color: Colors.green,
                          ))
              ],
            )),
        Container(
            // decoration: themeData.decorationInputs(0.0),
            margin: EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: data.lastName ?? '',
                    onChanged: (e) => _lastName = e,
                    enabled: isEditLastName,
                    keyboardType: TextInputType.emailAddress,
                    decoration: themeData.inputDecoration(' Apellido', false),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      isEditLastName = !isEditLastName;
                      setState(() {});
                      if (!isEditLastName) {
                        final data =
                            await userProvider.updateLastName(_lastName.trim());
                        if (data == 'ok') {
                          Fluttertoast.showToast(
                              msg: 'Apellido actualizado con exito');
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Error, intente nuevamente');
                        }
                        print('edit con exito');
                      }
                    },
                    icon: (!isEditLastName)
                        ? Icon(Icons.edit)
                        : Icon(
                            Icons.check,
                            color: Colors.green,
                          ))
              ],
            )),
      ],
    );
  }

  Widget subscripciones(AlertModel data,BuildContext context) {
    return Container(
      child: Row(        
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        children: [          
          Container(
            alignment:Alignment.center,
            
            height: MediaQuery.of(context).size.height*0.1,
            child: Text('${data.value!.type}')),
            SizedBox(width: 20,),
          Container(
            alignment:Alignment.centerLeft,
            
            height: MediaQuery.of(context).size.height*0.1,
            child: Text('${data.value!.status}')),
        ],
      ),
    );
  }
}
