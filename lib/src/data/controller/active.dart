


import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier{



 bool _isActive = false;



 set isActive(bool ia){
   _isActive = ia;
   notifyListeners();
 }
 get active => _isActive;
}