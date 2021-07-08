import 'package:flutter/material.dart';

class Login extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar:AppBar(
        title: Text('Pastor'),
        centerTitle: true
      ),
      body:_form(context)      
    );
  }


  Widget _form(context){
    return Column(
        children:[
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            color:Colors.red
          )
        ]
    );
  }
}