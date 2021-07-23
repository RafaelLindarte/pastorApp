


import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier{



 bool _isActive = false;
 String _typeAlert ='';


 set isActive(bool ia){
   _isActive = ia;
   notifyListeners();
 }

 set typeAlert(String type) {
   _typeAlert = type;
   notifyListeners();

 }
 get typeAler => _typeAlert;
 get active => _isActive;
}