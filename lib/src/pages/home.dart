
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';
import 'package:push_notificaction/src/widgets/on_of.dart';



class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _notificationProvider = Provider.of<NotificationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pastor'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,            
            height: MediaQuery.of(context).size.height*0.3,
            child: ElevatedButton(
              child: TextOnOf(), 
              onPressed: (){
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
          Container(
            child: FutureBuilder(
              builder:(context, snaphsot){
                if(snaphsot.hasData){
                  return Center(child: CircularProgressIndicator());
                }else{
                  return Center(child: Text('listar notificaciones'));
                }

              }
            )
          )

        ],
      ),
      
    );
  }
}