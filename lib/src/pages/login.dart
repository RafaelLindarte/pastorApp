import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/cognito/cognito.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:push_notificaction/src/style/theme.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


// ignore: must_be_immutable
class Login extends StatelessWidget {



  
  final cognito = Cognito(); 
  final themeData = StyleData();

  String name   = '';
  String email  = '';
  String pass   = '';
  String conf   = '';
  String apee   = '';
  String emaill = '';
  String passwl = '';
  final _preferences = Preferences();

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
        child: Container(
          height: MediaQuery.of(context).size.height*0.1, 
          child: Image(
            
            image: AssetImage('assets/logoApp.png'),
            fit: BoxFit.contain,
          ),
        )   ,
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        color: Colors.red.withOpacity(0.9),        
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
                    style: themeData.styles(20.0, Colors.red),
                  ),
                  Text('SIGNUP', style: themeData.styles(20.0, Colors.red)),
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
        SizedBox(height: 17,),        
      GestureDetector(
        child:Text('Olvide mi contraseña'),
        onTap: (){
          Navigator.pushNamed(context, 'recuperar');
        },
      ),
        SizedBox(height: MediaQuery.of(context).size.height*0.1),
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
        onPressed: () {
          Fluttertoast.showToast(msg: 'Login con Google');
        },
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
        onPressed: () {
          Fluttertoast.showToast(msg: 'Login con Facebook');
        },
        shape: themeData.shape(),
      ),
    );
  }

  Widget _inputs(){

    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            onChanged: (e)=>emaill = e,
            keyboardType: TextInputType.emailAddress,
            decoration: themeData.inputDecoration(' Correo', false),
          ),
        ),
        SizedBox(height: 8,),

        Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(  
            obscureText:true,
            onChanged:(e)=> passwl = e, 
            decoration: themeData.inputDecoration(' Contraseña', true),
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
          primary: Colors.red.withOpacity(0.9),          
        ),
        onPressed: () async{
          final result = await cognito.singIn(emaill, passwl);
          if(result=='ok'){
            Fluttertoast.showToast(msg: 'Por favor espere');
            Navigator.pushReplacementNamed(context, 'home');
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
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
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            onChanged: (e)=> name = e,
            
            
            decoration: themeData.inputDecoration(' Nombre', false),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            onChanged: (e)=> apee = e ,
            
            
            decoration: themeData.inputDecoration(' Apellido', false),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            onChanged: (e)=> email = e,
            keyboardType: TextInputType.emailAddress,                    
            decoration: themeData.inputDecoration(' Correo', false),
          ),
        ),
        SizedBox(height: 8,),

        Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(               
            obscureText: true,
            onChanged: (e)=> pass = e,

            decoration: themeData.inputDecoration(' Contraseña', true),
          ),
        ),
        SizedBox(height: 8,),

        Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(                      
            onChanged: (e)=> conf = e,
            obscureText: true,

            decoration: themeData.inputDecoration(' Confirma Contraseña', true),
          ),
        ),
        SizedBox(height: 8,),
      _buttonRegistro(context), 
        SizedBox(height: 8,),
    Container(
      // alignment: Alignment.bottomRight,
          height: MediaQuery.of(context).size.height*0.1, 
          margin:EdgeInsets.only(right: 30),
          child: Image(
            
            image: AssetImage('assets/logopatr.png'),
            fit: BoxFit.contain,
          ),
        )



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
          primary: Colors.red.withOpacity(0.9),          
        ),
        onPressed: () async{
          print('a');
          final result = await cognito.singUp(email.trim(), pass.trim(), conf.trim(), name.trim());
          if(result == 'ok') {
            _preferences.name = name.trim();
            _preferences.lastname = apee.trim();
            Navigator.pushReplacementNamed(context, 'confirm');
            Fluttertoast.showToast(msg: 'Registro Exitoso');
          }else{
            Fluttertoast.showToast(msg: result);
                      }
        }, 
        child: Text('Registrarme')
        
        ),
    );
}
}
