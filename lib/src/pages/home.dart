import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/notificaciones.dart';
import 'package:push_notificaction/src/data/provider/user-provider.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:push_notificaction/src/style/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final d = {
    "evento": [
      {
        "name": "Sismica",
        "status": true,
      },
      {
        "name": "Forestal",
        "status": true,
      },
      {
        "name": "Tormenta tropical",
        "status": true,
      }     
    ]
  };


  String _alert ='';
  

  @override
  void initState() {
    super.initState();
    final _preferences = Preferences();

    if (_preferences.iswelcome == null) {
      _preferences.isWelcome = 'ok';
      if (mounted) {
        Future.delayed(Duration.zero, () {
          this.welcome();
        });
      }
    }
    Notificaciones.messagesStream.listen((event) {
      Fluttertoast.showToast(msg: 'Recibiste una notificacón');
    });
  }

  void welcome() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 4.0,
            content: Text('Bienvenido al sistema de alerta temprana'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Continuar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _preferences = Preferences();
    List<dynamic> dd = d['evento']!.toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red.withOpacity(0.9),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'account');
                  },
                  icon: Icon(Icons.account_circle_sharp)),
              Text('Pastor'),
              IconButton(
                  onPressed: () {
                    addAlert(context);
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: Container(
          color: Colors.grey.withOpacity(0.16),
          padding: EdgeInsets.only(top: 30),
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {              
              return _cardEstaciones(dd[index]);
            },
            itemCount: dd.length,
          ),
        ),
      ),
    );
  }

  Widget _cardEstaciones(dynamic data) {
    final userProvider = USerProvider();

    return GestureDetector(
      child: Container(
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

                          setState(() {
                            data['status'] = !data['status'];
                          });

                          
                        },
                        icon: (data['status'])
                            ? FaIcon(FontAwesomeIcons.bell, color: Colors.green)
                            : FaIcon(
                                FontAwesomeIcons.bellSlash,
                                color: Colors.red,
                              ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    '${data['name']}',
                    style: TextStyle(fontSize: 13),
                  ),
                )
              ],
            )),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'notifications');
      },
    );
  }

  List<String> alertas = [
    'Selecciona',
    'Tormenta',
    'Erupcion',
    'Inundación',
    'Incendio',
    'Tsunami'
  ];
  String _opc = 'Selecciona';

  List<DropdownMenuItem> getItem() {
    List<DropdownMenuItem> list = [];
    alertas.forEach((element) {
      list.add(DropdownMenuItem(child: Text(element), value: element));
    });
    return list;
  }

  Widget _lista() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DropdownButtonFormField<dynamic>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          isExpanded: true,
          value: _opc,
          items: getItem(),          
          onChanged: (d) {
            setState(() {
              _opc = d;
              _alert = d;
        
            });
          }),
    );
  }

  void addAlert(BuildContext context) {
    final themeData = StyleData();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 4.0,
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(child: Text('Agrega una alerta')),
                  SizedBox(
                    height: 10,
                  ),
                  _lista(),
                  Container(
                    child: Text('Dale un nombre (Opcional)'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: themeData.decorationInputs(10.0),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      // onChanged:(e)=> passwl = e,
                      decoration: themeData.inputDecoration(' Mi alerta', true),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: themeData.shape(),
                        primary: Colors.red.withOpacity(0.9),
                      ),
                      onPressed: () {
                        setState(() {
                        d['evento']!.add({"name":_alert, "status":true});
                          
                        });
                        print(d['evento']);
                      },
                      child: Text('Agregar'))
                ],
              ),
            ),
          );
        });
  }
}
