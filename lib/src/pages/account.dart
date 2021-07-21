import 'package:flutter/material.dart';
import 'package:push_notificaction/src/style/theme.dart';

class AcountPage extends StatefulWidget {
  AcountPage({Key? key}) : super(key: key);

  @override
  _AcountPageState createState() => _AcountPageState();
}

class _AcountPageState extends State<AcountPage> {
  final themeData = StyleData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.red.withOpacity(0.9),
              title: Text('Tu Cuenta'),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app))
              ],
            ),
            body: Stack(
              children: [
                Container(
                  color: Colors.grey.withOpacity(0.16),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Card(                      
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
          decoration: themeData.decorationInputs(0.0),

                            child: TextField(
                              // onChanged: (e)=>emaill = e,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  themeData.inputDecoration(' Nombre', true),
                            ),
                          ),
                          SizedBox(height: 3.0,),
                          Container(
          decoration: themeData.decorationInputs(0.0),

                            child: TextField(
                              // onChanged: (e)=>emaill = e,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  themeData.inputDecoration(' Apellido', true),
                            ),
                          ),
                          SizedBox(height: 3.0,),
                          Container(
          decoration: themeData.decorationInputs(0.0),

                            child: TextField(
                              // onChanged: (e)=>emaill = e,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  themeData.inputDecoration(' Correo', false),
                            ),
                          ),
                          SizedBox(height: 3.0,),
                          Container(
          decoration: themeData.decorationInputs(0.0),

                            child: TextField(
                              // onChanged: (e)=>emaill = e,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  themeData.inputDecoration(' Correo', false),
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
