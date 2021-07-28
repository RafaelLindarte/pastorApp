
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/cognito/cognito.dart';
import 'package:push_notificaction/src/style/theme.dart';


// ignore: must_be_immutable
class RecuperarContrasena extends StatefulWidget {
  @override
  _RecuperarContrasenaState createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  final themeData = StyleData();
  final cognito = Cognito();

  TextEditingController _emailController    = TextEditingController();
  TextEditingController _codeController     = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


    @override
    void dispose(){
      super.dispose();
        _emailController.dispose();
        _codeController.dispose();
        _passwordController.dispose();
    }
  String email = '';
  String pass = '';
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.withOpacity(0.9),
          title: Text('Recupera tu contraseña'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
                 SizedBox(height: 20,),                 
           (isVisible) ?
            Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            // onChanged: (e)=>email = e,
            keyboardType: TextInputType.emailAddress,
            controller:_emailController,            
            decoration: themeData.inputDecoration(' Correo', false,'null'),
          ),
        ):newPassword(),
        
        SizedBox(height: 10,),
        (isVisible)?_button(context):_buttonNewPassword(),
            ],
          ),
        ),
        ),
      
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
        onPressed: ()async{      
          print(_emailController.text);
          final result = await cognito.enviarCodigo(_emailController.text);
          if(result == 'ok'){
            Fluttertoast.showToast(msg: 'Se ha enviado un código a su correo electronico');
            setState(() {              
              isVisible = false;
            });
          }else{
            Fluttertoast.showToast(msg: result);
          }
        }, 
        child: Text('Enviar código')
        
        ),
    );
}

Widget newPassword(){
  return Column(
    children: [
 Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            // onChanged: (e)=>email = e,
                controller: _codeController,
keyboardType: TextInputType.number,
            decoration: themeData.inputDecoration(' Codigo', false,'null'),
          )),
          SizedBox(height:8.0),
 Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            // onChanged: (e)=>email = e,
            obscureText: true,
            controller: _passwordController,            
            decoration: themeData.inputDecoration(' Nueva Contraseña', true,'null'),
          )),
        

    ],
  );
}

Widget _buttonNewPassword(){
    final size = MediaQuery.of(context).size;
    return Container(      
      width: size.width * 0.8,
      height: size.height*0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:  themeData.shape(),
          primary: Colors.red.withOpacity(0.9),          
        ),
        onPressed: ()async{      
          print(_emailController.text);
          final result = await cognito.changePassword(_emailController.text, _codeController.text, _passwordController.text);
          if(result == 'ok'){
            Fluttertoast.showToast(msg: 'Contraseña restaurada');
            Navigator.popAndPushNamed(context, 'login');
            
          }else{
            Fluttertoast.showToast(msg: result);
          }
        }, 
        child: Text('Cambiar Cotraseña')
        
        ),
    );
}
}