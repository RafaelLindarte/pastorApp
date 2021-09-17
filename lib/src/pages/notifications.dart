import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';
import 'package:push_notificaction/src/data/model/alertas.dart';
import 'package:push_notificaction/src/data/provider/alertas-provider.dart';
import 'package:push_notificaction/src/data/provider/user-provider.dart';

class NotificacionesPage extends StatefulWidget {
String type;
String status;
String keys;
NotificacionesPage({this.status='', this.type='', this.keys= ''});  

  @override
  _NotificacionesPageState createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  


  AlertasProvider alertasProvider = AlertasProvider();

  ScrollController _scrollController = ScrollController();
  int add = 0;
  int create = 0;
  List<Item> alertItems =[];
  String type = '';
  String status  = '';
  String arn  = '';
  String key  = '';
  @override
  void initState() {
    super.initState();
    status = widget.status;
    getfirstAlerts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMores();
      }
    });
  }

  getMores() async {        
    
    if(create!=0){
      print('sssssa $create');
      final result = await alertasProvider.getMoreAlerts(create, widget.type);         
    
    setState(() {
         List<Item> alertItem = result[0];
         
         
         alertItem.forEach((element) {           
           alertItems.add(element);
         });
       if(result[1]!=null){       
         create = result[1];       
        }else{
          add =0;
          setState(() {
            
          });
        }
    });
  }
  }
  void getfirstAlerts() async {    
    status = widget.status;
    
    final result = await alertasProvider.getFirstAlerts(widget.type);
     if(result.length==0){
        alertItems=[];
     }else{       
    Future.delayed(Duration(seconds: 3));
       alertItems = result[0];       
      create = result[1];
     }
    setState(() {});
  }
  final userProvider = USerProvider();
bool isActive = true;
  @override
  Widget build(BuildContext context) {
      
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton( icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, 'home')),
          title: Text('Alertas'),
          centerTitle: true,
          backgroundColor: Colors.red.withOpacity(0.9),
          actions: [
            IconButton(
                onPressed: () async{                  
                       if(status=='Active'){
                            Fluttertoast.showToast(msg: 'Desactivando notificaciones para ${widget.type}');
                            await userProvider.inactive(arn, widget.keys);
                            setState(() {
                              isActive = !isActive;
                              status = 'Inactive';
                            });
                          }else{
                            Fluttertoast.showToast(msg: 'Activando notificaciones para ${widget.type}');
                             await userProvider.active(widget.type, widget.keys);
                             setState(() {
                              isActive = !isActive;
                              status = 'Active';
                            });
                          }
                          setState(() {
                            
                          });
                },
                 icon: (status=='Active')
                            ? FaIcon(FontAwesomeIcons.bell, color: Colors.yellow)
                            : FaIcon(
                                FontAwesomeIcons.bellSlash,
                                color: Colors.grey,
                              ))
          ],
        ),
        body: Stack(children: [
          Container(
            color: Colors.grey.withOpacity(0.16),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 25),
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if(index==alertItems.length){
                    return Center(child: CupertinoActivityIndicator());
                  }else{
                    
                    if(alertItems.length==0){
                      return Center(child:Text('No hay alertas'));

                    }else{
                      return _alertas(alertItems[index]);
                    }
                  }
                },
                itemCount: alertItems.length+add
                // itemCount: add+1,
              ),
              ),
        ]),
      ),
    );
  }

  Widget _alertas(Item i) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.only(right: 50, left: 50),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text('${i.eventTime}'),
                  Text(
                    '${i.eventDay}',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 55.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 28,
                    ),                    
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Estación: ${i.station}')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _alertasDemo() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.only(right: 50, left: 50),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text('x].ev'),
                  Text(
                    'Lunes',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 55.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Evento: ')),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Estación:')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
