import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/data/blocs/auth_blocs/auth_bloc_bloc.dart';
import 'package:push_notificaction/src/data/cognito/cognito.dart';
import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:push_notificaction/src/style/theme.dart';

class SinUP extends StatefulWidget {
  @override
  _SinUPState createState() => _SinUPState();
}

class _SinUPState extends State<SinUP> {
  final themeData = StyleData();
  final cognito = Cognito();

TextEditingController _nameController  = TextEditingController();
TextEditingController _lastNameController  = TextEditingController();
TextEditingController _emailController  = TextEditingController();
TextEditingController _passwController  = TextEditingController();
TextEditingController _confpasswController  = TextEditingController();
    
  bool isVisible = true;
  bool isVisibleconfi = true;
  final _preferences = Preferences();
  @override
  void dispose() {
  _nameController.dispose();
  _lastNameController.dispose();
  _emailController.dispose();
  _passwController.dispose();
  _confpasswController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _bodyTab2(context),
    );
  }

  Widget _bodyTab2(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30.0),
         _campoName(context),
          SizedBox(
            height: 8,
          ),
         _campoLastName(context),
          SizedBox(
            height: 8,
          ),
          _campoEmail(context),
          SizedBox(
            height: 8,
          ),
          _campoContrasenia(context) ,
          SizedBox(
            height: 8,
          ),
          _campoContraseniaConfirm(context),
          SizedBox(
            height: 8,
          ),
          _buttonRegistro(context),
          SizedBox(
            height: 8,
          ),
          Container(
            // alignment: Alignment.bottomRight,
            height: MediaQuery.of(context).size.height * 0.1,
            margin: EdgeInsets.only(right: 30),
            child: Image(
              image: AssetImage('assets/logopatr.png'),
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
  Widget _campoName(BuildContext context){
    return  Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              themeData
                  .paddingInputs(Icon(Icons.person_outline, color: Colors.red)),
              themeData.separadadirInputs(),
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration:
                      themeData.inputDecoration(' Nombre', false, 'null'),
                ),
              )
            ],
          ),
        );
  }

  Widget _campoLastName(BuildContext context){
    return  Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              themeData
                  .paddingInputs(Icon(Icons.person_outline, color: Colors.red)),
              themeData.separadadirInputs(),
              Expanded(
                child: TextField(
                  controller: _lastNameController,
                  decoration:
                      themeData.inputDecoration(' Apellido', false, 'null'),
                ),
              )
            ],
          ));        
  }

  Widget _campoEmail(BuildContext context){
    final changeTabBloc = BlocProvider.of<AuthBlocBloc>(context);    
    return StreamBuilder(
      stream: changeTabBloc.emailController,
      builder: (_, AsyncSnapshot snapshot){
        
        return Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              themeData.paddingInputs(
                  Icon(Icons.email, color: Colors.red)),
              themeData.separadadirInputs(),
              Expanded(
                child: TextField(
                  controller:_emailController,
                  onChanged: (e) => changeTabBloc.add(InputUser(e.trim())),
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      themeData.inputDecoration(' Correo Electronico', false, snapshot.error.toString())
                ),
              )
            ],
          ),
        );
      });
  } 
  Widget  _campoContrasenia(BuildContext context){
    final changeTabBloc = BlocProvider.of<AuthBlocBloc>(context);    

    return StreamBuilder(
      stream:changeTabBloc.passController,
      builder: (_, AsyncSnapshot snapshot){
        return Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
           child: Row(
            children: [
              themeData.paddingInputs(
                  Icon(Icons.lock_open, color: Colors.red)),
              themeData.separadadirInputs(),
              Expanded(
              child: TextField(
            obscureText: isVisible,
            controller:_passwController,
            onChanged: (e) => changeTabBloc.add(InputPass(e.trim())) ,
            decoration: themeData.inputDecoration(' Contraseña', false, snapshot.error.toString())
          ),
              ),
              IconButton(onPressed: (){
                  isVisible = !isVisible;
                          setState((){});
                }, icon: (isVisible)?Icon(Icons.visibility):Icon(Icons.visibility_off))
            ],
          ),        

          
        );
      },
    );
  }

  Widget _campoContraseniaConfirm(BuildContext context){
    return         Container(
          decoration: themeData.decorationInputs(10.0),
          margin: EdgeInsets.symmetric(horizontal: 40),
           child: Row(
            children: [
              themeData.paddingInputs(
                  Icon(Icons.lock_open, color: Colors.red)),
              themeData.separadadirInputs(),
              Expanded(
                child: TextField(
            controller: _confpasswController,
            obscureText: isVisibleconfi,
            decoration: themeData.inputDecoration(
                ' Confirma Contraseña', false, 'null'),
          ),
              ),
                IconButton(onPressed: (){
                  isVisibleconfi = !isVisibleconfi;
                          setState((){});
                }, icon: (isVisibleconfi)?Icon(Icons.visibility):Icon(Icons.visibility_off))
            ],
          ), 
        
        );
  }

  Widget _buttonRegistro(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.07,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: themeData.shape(),
            primary: Colors.red.withOpacity(0.9),
          ),
          onPressed: () async {            
            final result = await cognito.singUp(
                _emailController.text.trim(), _passwController.text.trim(), _confpasswController.text.trim(), _nameController.text.trim());
            if (result == 'ok') {
              _preferences.name = _nameController.text.trim();
              _preferences.lastname = _lastNameController.text.trim();
              Navigator.pushReplacementNamed(context, 'confirm');
              Fluttertoast.showToast(msg: 'Registro Exitoso');
            } else {
              Fluttertoast.showToast(msg: result);
            }
          },
          child: Text('Registrarme')),
    );
  }
}
