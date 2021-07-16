import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/cognito/cognito.dart';
// import 'package:push_notificaction/src/data/login.dart';
// import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:push_notificaction/src/style/theme.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';


class Login extends StatelessWidget {



  
  final cognito = Cognito(); 
  final themeData = StyleData();

  String name   = '';
  String email  = '';
  String pass   = '';
  String conf   = '';
  String emaill = '';
  String passwl = '';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            _banner(context),
            Container(            
              child: _body(context),
              height: MediaQuery.of(context).size.height * 0.76,
            ),
          ]),
        ),
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
            children: [_bodyTab1(context), _bodyTab2(context)],
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
            onChanged: (e)=>emaill = e,
            
            decoration: themeData.inputDecoration(' Correo'),
          ),
        ),
        SizedBox(height: 8,),

        Container(
          decoration: themeData.decorationInputs(),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(  
            onChanged:(e)=> passwl = e, 
            decoration: themeData.inputDecoration(' Contraseña'),
          ),
        ),
      
      ],
      );
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
        onPressed: () async{
          final result = await cognito.singIn(emaill, passwl);
          if(result=='ok'){
            Fluttertoast.showToast(msg: 'Por favor espere');
            Navigator.pushReplacementNamed(context, 'home');
          }else{
            Fluttertoast.showToast(msg: result);

          }
        }, 
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

Widget _bodyTab2(BuildContext context){
  return Column(
    children: [
        SizedBox(height: 30.0),
        Container(
          decoration: themeData.decorationInputs(),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            onChanged: (e)=> name = e,
            
            
            decoration: themeData.inputDecoration(' Nombre'),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          decoration: themeData.decorationInputs(),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            onChanged: (e)=> email = e,
            
            
            decoration: themeData.inputDecoration(' Correo'),
          ),
        ),
        SizedBox(height: 8,),

        Container(
          decoration: themeData.decorationInputs(),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(               
            onChanged: (e)=> pass = e,

            decoration: themeData.inputDecoration(' Contraseña'),
          ),
        ),
        SizedBox(height: 8,),

        Container(
          decoration: themeData.decorationInputs(),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(                      
            onChanged: (e)=> conf = e,

            decoration: themeData.inputDecoration(' Confirma Contraseña'),
          ),
        ),
        SizedBox(height: 8,),
      _buttonRegistro(context)        
    ],
  );
}

Widget _buttonRegistro(BuildContext context){   
   final size = MediaQuery.of(context).size;
    return Container(      
      width: size.width * 0.8,
      height: size.height*0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:  themeData.shape(),
          primary: Colors.orangeAccent.withOpacity(0.9),          
        ),
        onPressed: () async{
          print('a');
          final result = await cognito.singUp(email.trim(), pass.trim(), conf.trim(), name.trim());
          if(result == 'ok') {
            Navigator.pushReplacementNamed(context, 'confirm');
            Fluttertoast.showToast(msg: 'Registro Exitoso');
          }else{
            print(result);
          }
        }, 
        child: Text('Registrarme')
        
        ),
    );
}



final userPool = CognitoUserPool(
  'us-east-1_ACURJmxp4',
  '3if8rq6er825l3rnl9csfj4e3h',
);

// void _singUp() async{
//   try{

//     final userAttributes = [
//   AttributeArg(name: 'email', value: 'ar2224518@gmail.com'),
//   AttributeArg(name: 'name', value: 'p'),
// ];

// var data;
// try {
//   data = await userPool.signUp(
//     'ar2224518@gmail.com',
//     'andres',
//      userAttributes: userAttributes,
//    );
// } catch (e) {
//   print(e);
// }
//       // await _userService.signUp('ar2224518@gmail.com', 'and123rtaaaAs', 'prueba', 'pr');
//       print('a');
//   }catch(e){
//   }
// }
}
