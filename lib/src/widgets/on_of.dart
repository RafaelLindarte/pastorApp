


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaction/src/data/controller/active.dart';

class TextOnOf extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final _notificationProvider= Provider.of<NotificationProvider>(context);
    return Text((_notificationProvider.active) ? 'OF' : 'ON');
  }
}