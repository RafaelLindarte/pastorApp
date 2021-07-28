


import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier{



 String _isActive = '';
 String _typeAlert ='';
 String _arn ='';
 String _key ='';


 set isActive(String ia){
   _isActive = ia;
   notifyListeners();
 }
 set serarn(String arn){
   _arn = arn;
   notifyListeners();
 }
 set setkey(String key){
    _key = key;
   notifyListeners();
 }

 set typeAlert(String type) {
   _typeAlert = type;
   notifyListeners();

 }
 get typeAler => _typeAlert;
 get active => _isActive;
 get key => _key;
 get arn => _arn;
}