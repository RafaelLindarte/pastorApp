

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/blocs/auth_blocs/auth_bloc_bloc.dart';
import 'package:push_notificaction/src/data/cognito/cognito.dart';
import 'package:push_notificaction/src/style/theme.dart';

class SingIn extends StatefulWidget {
  

  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {

  final themeData = StyleData();
  final cognito = Cognito();
  bool isVisible = true;
TextEditingController _emailController =TextEditingController();
TextEditingController _passwController =TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _inputs(context),
    );
  }

  Widget _inputs(BuildContext context) {
    final changeTabBloc = BlocProvider.of<AuthBlocBloc>(context);    
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),

        //Input para el email
        StreamBuilder(
            stream: changeTabBloc.emailController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                // height: MediaQuery.of(context).size.height*0.07,
                decoration: themeData.decorationInputs(10.0),
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    themeData.paddingInputs(
                        Icon(Icons.person_outline, color: Colors.red)),
                    themeData.separadadirInputs(),
                    Expanded(
                        child: TextField(
                          controller: _emailController,
                        keyboardType: TextInputType.emailAddress,                          
                      onChanged: (e) {
                        return changeTabBloc.add(InputUser(e.trim()));
                      },
                      decoration: themeData.inputDecoration(
                          ' Correo electronico',
                          false,
                          snapshot.error.toString()),
                    )),
                   
                  ],
                ),
              );
            }),
        SizedBox(
          height: 8,
        ),
        StreamBuilder(
            stream: changeTabBloc.passController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                // height: MediaQuery.of(context).size.height*0.07,
                decoration: themeData.decorationInputs(10.0),
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    themeData.paddingInputs(
                        Icon(Icons.lock_open, color: Colors.red)),
                    themeData.separadadirInputs(),
                    Expanded(
                        child: TextField(
                          controller: _passwController,
                      obscureText: isVisible,
                      onChanged: (e) {
                        return changeTabBloc.add(InputPass(e.trim()));
                      },
                      decoration: themeData.inputDecoration(
                          ' Contraseña', false, snapshot.error.toString()),
                    )),
                     IconButton(
                        onPressed: () {
                          isVisible = !isVisible;
                          setState((){});
                        },
                        icon: (isVisible)?Icon(Icons.visibility):Icon(Icons.visibility_off)
                        )
                  ],
                ),
              );
            }),
         SizedBox(height: 15.0),        
            _button(context),
                    SizedBox(height: 17,),        

                  GestureDetector(
        child:Text('Olvide mi contraseña'),
        onTap: (){
          Navigator.pushNamed(context, 'recuperar');
        },
      )
      ],
    );
  }
   Widget _button(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      height: size.height * 0.07,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: themeData.shape(),
            primary: Colors.red.withOpacity(0.9),
          ),
          onPressed: () async {
            final result = await cognito.singIn(_emailController.text, _passwController.text);
            if (result == 'ok') {
              Fluttertoast.showToast(msg: 'Por favor espere');
              Navigator.pushReplacementNamed(context, 'home');              
            } else {
              Fluttertoast.showToast(msg: result);
            }
          },
          child: Text('Ingresar')),
    );
  }
}