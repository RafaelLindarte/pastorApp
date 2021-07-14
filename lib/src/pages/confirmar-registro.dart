import 'package:flutter/material.dart';
import 'package:push_notificaction/src/style/theme.dart';

class Confirm extends StatelessWidget {
  final themeData = StyleData();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('pastor'),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent.withOpacity(0.9)
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text('Ya casi!!!\Revisa tu correo e ingresa el código de confirmación'),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: themeData.decorationInputs(),
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  // onChanged: (e)=> email = e,

                  decoration: themeData.inputDecoration(' Ingresa el código'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
