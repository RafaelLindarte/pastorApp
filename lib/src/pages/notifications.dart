import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:push_notificaction/src/data/model/alertas.dart';
import 'package:push_notificaction/src/data/provider/alertas-provider.dart';

class NotificacionesPage extends StatefulWidget {
  @override
  _NotificacionesPageState createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  AlertasProvider alertasProvider = AlertasProvider();

  ScrollController _scrollController = ScrollController();
  int add = 8;
  int create = 0;
  List<Item> alertItems =[];
  @override
  void initState() {
    super.initState();
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
      final result = await alertasProvider.getMoreAlerts(create);         
    
    setState(() {
         List<Item> alertItem = result[0];
         
         
         alertItem.forEach((element) {           
           alertItems.add(element);
         });
       if(result[1]!=null){       
         create = result[1];       
        }
    });
  }
  }
  void getfirstAlerts() async {
    final result = await alertasProvider.getFirstAlerts();
     alertItems = result[0];
      create = result[1];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Alertas'),
          centerTitle: true,
          backgroundColor: Colors.red.withOpacity(0.9),
          actions: [
            IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.bell, color: Colors.yellow))
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
                    
                    return _alertas(alertItems[index]);
                  }
                },
                itemCount: alertItems.length+1
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
