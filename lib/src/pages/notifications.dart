import 'package:flutter/material.dart';

class NotificacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notificaciones'),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent.withOpacity(0.9),
        ),
        body: Container(
          color: Colors.grey.withOpacity(0.16),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.only(right: 30, left: 30),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        SizedBox(height: 25,),
                            Text('12:00 PM'),
                            Text('Lunes', style: TextStyle(fontSize: 10),)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 55.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.55,                          
                          alignment: Alignment.center,
                          child: Text('Alerta'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 6,
          ),
        ),
      ),
    );
  }
}
