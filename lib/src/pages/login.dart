import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/login.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:push_notificaction/src/style/theme.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatelessWidget {
  final themeData = StyleData();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          _banner(context),
          Container(            
            child: _body(context),
            height: MediaQuery.of(context).size.height * 0.76,
          ),
        ]),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 10,
              width: double.infinity,
            ),
            Icon(Icons.person_pin_circle, color: Colors.white, size: 70),
            SizedBox(
              height: 10,
              width: double.infinity,
            ),
            Text('Pastor', style: themeData.styles(25.0, Colors.white))
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        color: Colors.orangeAccent.withOpacity(0.9),        
        );
  }

  Widget _body(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: Container(
              height:40,
              child: TabBar(
                tabs: [
                  Text(
                    'SIGN IN',
                    style: themeData.styles(20.0, Colors.orangeAccent),
                  ),
                  Text('SIGNUP', style: themeData.styles(20.0, Colors.orangeAccent)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [_bodyTab1(context), Text('2')],
          ),
        ));
  }

  Widget _bodyTab1(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.0),
        _buttonGoogle(context),
        SizedBox(height: 10.0),
        _buttonFacebook(context),
        SizedBox(height: 10.0),
        Container(
          child: Text('También puedes ingresar con'),
        ),
        _inputs(),
        SizedBox(height: 10.0),
        _button(context),
        SizedBox(height: MediaQuery.of(context).size.height*0.15),
        _footer()
      ],
    );
  }

  Widget _buttonGoogle(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      width: size.width * 0.8,
      child: SignInButton(
        Buttons.Google,
        text: 'Ingresa con Google',
        onPressed: () {},
        shape:  themeData.shape(),
      ),
    );
  }

  Widget _buttonFacebook(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      width: size.width * 0.8,
      child: SignInButton(
        Buttons.Facebook,
        text: 'Ingresa con Facebook',
        onPressed: () {},
        shape: themeData.shape(),
      ),
    );
  }

  Widget _inputs(){

    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
          decoration: themeData.decorationInputs(),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            
            
            decoration: themeData.inputDecoration(' Correo'),
          ),
        ),
        SizedBox(height: 8,),

        Container(
          decoration: themeData.decorationInputs(),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(                      
            decoration: themeData.inputDecoration(' Contraseña'),
          ),
        ),
      
      ],);
  }
Widget _button(BuildContext context){   
   final size = MediaQuery.of(context).size;
    return Container(      
      width: size.width * 0.8,
      height: size.height*0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:  themeData.shape(),
          primary: Colors.orangeAccent.withOpacity(0.9),          
        ),
        onPressed: (){}, 
        child: Text('Ingresar')
        
        ),
    );
}

Widget _footer(){

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    
    Text('Documentación'),
    Text('Politicas de priva.'),
    Text('Terminos y cond.')
  ],);
}
}
