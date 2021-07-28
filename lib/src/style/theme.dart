import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

BoxDecoration decorationInputs(double radio){ // decora el fondo de  los inputs, estilo de un container

  return  BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(
              color: Colors.grey.withOpacity(0.0),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(radio),
          );
}

InputDecoration inputDecoration(String hintTextS, bool icon, String error ){// decoracion del input
  return InputDecoration(
    border: InputBorder.none,
    hintText: hintTextS,        
    errorText: (error!='null')?error:null
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
FontAwesomeIcons icon = FontAwesomeIcons();
FontAwesomeIcons getIcons(String type){
final listIcon = {
  "icons":[
    {"type":"Sismica", "icon":'houseDamage'},
    {"type":"Tormenta", "icon":'pooStorm'},
    {"type":"Erupcion", "icon":'mountain'}
  ]
};
List list = [];
list.add(listIcon['icons']);
list.forEach((element) {
  if(element['type']==type){
    icon = element['icon'];
  }  
});
  return icon;
  
}
//para asignarle el icono izquierdo a los inputs
Padding paddingInputs(Icon data){
  return  Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,                  
                ),
                child: data,
              );
}
Container separadadirInputs(){
  return  Container(
                height: 40.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              );
}
}