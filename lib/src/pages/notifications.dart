import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Alertas'),
          centerTitle: true,
          backgroundColor: Colors.red.withOpacity(0.9),
          actions: [
            IconButton(onPressed: 
            (){}
            , icon: FaIcon(FontAwesomeIcons.bell, color: Colors.yellow))
          ],
        ),
        body: Stack(children: [
          Container(
            color: Colors.grey.withOpacity(0.16),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: ListView.builder(
              itemBuilder: (context, index) {
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
                              Text('12:00 PM'),
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
                            margin:
                                const EdgeInsets.only(left: 00.0, right: 10.0),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            alignment: Alignment.center,
                            child: Text('Alerta'),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: 5,
            ),
          ),
        ]),
      ),
    );
  }
}
