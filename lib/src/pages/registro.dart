import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/login.dart';
import 'package:push_notificaction/src/shared/preferences.dart';


class Registro extends StatelessWidget {


String _name      = '';
String _email     = '';
String _password  = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
     body:Stack(
       children:[
         _crearFondo(context),
         _loginForm(context)
       ]
     )      
    );
  }

  Widget _crearFondo(c){
  final size = MediaQuery.of(c).size;
  final  fondoMorado= Container(
    height: size.height*0.4,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(201, 158, 76, 1),
          Color.fromRGBO(255, 168, 0, 1),
        ]
      )
    ),
  );

  final circulo = Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100) ,
        color: Color.fromRGBO(255, 255, 255, 0.02)
      ) ,
  );

  return Stack(
    children: [
      fondoMorado,
      Positioned(child: circulo, top: 200,left: 290,),
      Positioned(child: circulo, top: 50,left: 30,),
      Positioned(child: circulo, top: 90,left: 90,),
      Positioned(child: circulo, top: 150,left:240,),
      Positioned(child: circulo, top: 110,left: 170,),           
      Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          
          children: [
            Icon(Icons.person_pin_circle, color: Colors.white, size: 70),
            SizedBox(height: 10,width: double.infinity,),
            Text('Pastor', style: TextStyle(color: Colors.white, fontSize: 25))
          ],
        )
      )
    ],
  );
  }

  Widget _loginForm(c){
    
    final size = MediaQuery.of(c).size;
    return SingleChildScrollView(
       child: Column(
         children: [
           SafeArea(
             child: Container(
               height: 180,
             )
           ), 
                     
           Container(   
             padding: EdgeInsets.symmetric(vertical: 50),          
             margin: EdgeInsets.symmetric(vertical: 30),          

             width: size.width*0.8,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(5),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black26,
                   blurRadius: 3,
                   offset: Offset(0.0, 5),
                   spreadRadius: 3
                   ),
               ]
             ),
             child: Column(                  

               children: [
                 Text('Ingreso', style: TextStyle(fontSize: 20)),
                 SizedBox(height: 20),
                 _crearName(),
                 _crearEmail(),
                 _crearPassword(),
                 SizedBox(height: 20),  
                 _button(c)              

               ],
             ),
           ),
           TextButton(
             child: Text('Iniciar sesion'),
             onPressed: ()=>Navigator.pushReplacementNamed(c,'login'),            
             
           ),
          ],
       ),
    );

  }
  

  Widget _crearName(){
    return StreamBuilder(
      
      builder: (c,s){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(        
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle, color: Colors.amber[800]),          
          labelText: 'Usuario',
          
        ),
        onChanged: (e){          
          _name = e;
        },
      )
    );
      },

      
      );

    
  }
  Widget _crearEmail(){
    return StreamBuilder(
      
      builder: (c,s){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.amber[800]),
          hintText: 'ejemplo@corre.com',
          labelText: 'Correo Electronico',
          
        ),
        onChanged: (e){          
          _email = e;
          
        },
      )
    );
      },      
      );

    
  }
  
  Widget _crearPassword(){

    return StreamBuilder(
     
     builder: (c, s){
            return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.amber[800]),          
          labelText: 'Password',
          
        ),
        onChanged: (e){
          _password = e;
        },
      )
    );
     }
    );
    
  }

  Widget _button(context){
    LoginController _loginController = LoginController();
    final predf = Preferences();
    return ElevatedButton(
      onPressed:()async{
        print(predf.token);
        final result = await _loginController.createUser(_name, _email, _password);
        if(result == 'ok'){
            Fluttertoast.showToast(msg: 'Registro exitoso');
            Navigator.pushReplacementNamed(context, 'home');
        }else{
            Fluttertoast.showToast(msg: result);
        }
      }, 
      child: Text('Registrarme'),

    );
  }


}