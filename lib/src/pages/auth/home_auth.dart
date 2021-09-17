import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:push_notificaction/src/pages/auth/sing_in.dart';
import 'package:push_notificaction/src/pages/auth/sing_up.dart';
import 'package:push_notificaction/src/style/theme.dart';

class HomeAuth extends StatelessWidget {
  final themeData = StyleData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _banner(context),
              Container(
                child: _body(context),
                height: MediaQuery.of(context).size.height * 0.76,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Image(
          image: AssetImage('assets/logoApp.png'),
          fit: BoxFit.contain,
        ),
      ),
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
              height: 40,
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
            children: [_bodyTab1(context), SinUP()],
          ),
        ));
  }

  Widget _bodyTab1(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30.0),
          _buttonGoogle(context),
          SizedBox(height: 10.0),
          _buttonFacebook(context),
          SizedBox(height: 10.0),
          Container(
            child: Text('También puedes ingresar con'),
          ),
          SingIn(),
          SizedBox(height: 10.0),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          _footer()
        ],
      ),
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
        shape: themeData.shape(),
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

  Widget _footer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Documentación'),
        Text('Politicas de priva.'),
        Text('Terminos y cond.')
      ],
    );
  }
}
