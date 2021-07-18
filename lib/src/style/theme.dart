import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';



//clase para implementar los estilos globales
class StyleData{


final styleText =TextStyle( fontSize: 20, color: Colors.orangeAccent);

TextStyle styles(double fontSize, Color color){

  return TextStyle( fontSize: fontSize, color: color);

  
}

 RoundedRectangleBorder shape()// especifica el borde de los botones
{
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
}

BoxDecoration decorationInputs(){ // decora el fondo de  los inputs, estilo de un container

  return  BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(
              color: Colors.grey.withOpacity(0.0),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          );
}

InputDecoration inputDecoration(String hintTextS, bool icon ){// decoracion del input
  return InputDecoration(
    border: InputBorder.none,
    hintText: hintTextS,
    // suffixIcon: (icon)? Icon(Icons.view):Text(''),
    
  );
}

Color colorOnOf(BuildContext context){
    final _notificationProvider = Provider.of<NotificationProvider>(context);
  
  if(!_notificationProvider.active){
    return Colors.green;
  }else {
    return Colors.red;
  }

}

}