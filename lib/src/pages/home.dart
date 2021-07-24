import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';
import 'package:push_notificaction/src/data/model/modelo-tarjetas-alertas.dart';
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

TextEditingController _editingController = TextEditingController();
  String _alert ='';
  String typeAlert = '';
  final userProvider = USerProvider();
  final _preferences = Preferences();
  bool isActive = true;
 final stleData =  StyleData();

  @override
  void initState() {
    super.initState();

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

@override
void dispose() { 
  
  super.dispose();
  _editingController.dispose();
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
          child: FutureBuilder(    
            future: userProvider.getAllAlertByUserId(), 
            builder: (BuildContext context, AsyncSnapshot<List<AlertModel>> snapshot){
              List<AlertModel> list = snapshot.data ?? [];
                if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else{
              return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {              
              return _cardEstaciones(list[index]);
            },
            itemCount:list.length,
          );
              }
            },          
          ),
        ),
      ),
    );
  }

  Widget _cardEstaciones(AlertModel data) {
    
    final notificationProvider = Provider.of<NotificationProvider>(context, listen:false);
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
                        )
                        ),
                    IconButton(
                        onPressed: () async {
                          // await userProvider.onOf();
                         
                          if(data.value!.status=='Active'){
                            Fluttertoast.showToast(msg: 'Desactivando notificaciones para ${data.key}');
                            await userProvider.inactive(data.value!.subscriptionArn.toString(), data.key.toString());
                            setState(() {
                              isActive = !isActive;
                            });
                          }else{
                            Fluttertoast.showToast(msg: 'Activando notificaciones para ${data.key}');
                             await userProvider.active(data.value!.type.toString(), data.key.toString());
                             setState(() {
                              isActive = !isActive;
                            });
                          }

                          
                        },
                        icon: (data.value!.status=='Active')
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
                    '${data.key}',
                    style: TextStyle(fontSize: 13),
                  ),
                )
              ],
            )),
      ),
      onTap: () {
        notificationProvider.typeAlert = data.value!.type.toString();
        Navigator.pushNamed(context, 'notifications', arguments: data.value!.type);
      },
    );
  }
  



  List<String> alertas = [
    'Selecciona',
    'Erupcion',
    'Sismica',
    'Tormenta',
   
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
    final userPorovider = USerProvider();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 4.0,
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    
                    child: Text('Agrega una alerta', style: TextStyle(fontWeight: FontWeight.bold),)),
                  SizedBox(
                    height: 10,
                  ),                  
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Dale un nombre (*)'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: themeData.decorationInputs(10.0),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _editingController,
                      decoration: themeData.inputDecoration(' Mi alerta', false),
                    ),
                  ),
                  _lista(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: themeData.shape(),
                        primary: Colors.red.withOpacity(0.9),
                      ),
                      onPressed: () async{
                        
                        if(_editingController.text.trim()!=''){
                          await userPorovider.createAler(_editingController.text.trim(), _alert);
                          setState(() {
                            
                          });
                          Navigator.pop(context);
                        }else{
                          Fluttertoast.showToast(msg: 'Debes de darle un nombre');
                        }
                      },
                      child: Text('Agregar'))
                ],
              ),
            ),
          );
        });
  }
}
