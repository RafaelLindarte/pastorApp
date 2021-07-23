import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:push_notificaction/src/data/model/alertas.dart';

class AlertasProvider {
  final _URL =
      'https://7nuyrr9ca3.execute-api.us-east-1.amazonaws.com/dev/controllerAlerts';

  Future<List> getFirstAlerts(String type) async {
    List<Item> alertItems = [];
    int lastEvaluatedKey = 0;

    try {
      String year = DateTime.now().year.toString();
      String month = DateTime.now().month.toString();
      String day = DateTime.now().day.toString();
      if (int.parse(day) < 10) {
        day = '0$day';
      }
      if (int.parse(month) < 10) {
        month = '0$month';
      }
      String fecha = "$year-$month-$day";

      final body = {"action": "listAlerts", "limit": '8', "type": type};
    print(type);
      final result = await http.post(Uri.parse(_URL),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'});
      final jsonData = json.decode(result.body);
      print(jsonData);
      if (jsonData['ok'] == true) {
        final data =
            Alerts.fromJson(jsonData['alerts'] as Map<String, dynamic>);
        alertItems = data.items!;
        lastEvaluatedKey = data.lastEvaluatedKey!.createdAt!;
      }
    } catch (e) {
      Future.error(e);
    }
    return [alertItems, lastEvaluatedKey];
  }
  Future<List> getMoreAlerts(int create, String type ) async {
    List<Item> alertItems = [];
    int lastEvaluatedKey =0;    
    try {
      String year = DateTime.now().year.toString();
      String month = DateTime.now().month.toString();
      String day = DateTime.now().day.toString();
      if (int.parse(day) < 10) {
        day = '0$day';
      }
      if (int.parse(month) < 10) {
        month = '0$month';
      }
      String fecha = "2021-07-21";

    if(create!=null && create != 0){      
        final body = {"action": "listAlerts", "date": fecha, "createdAt": create ,"type": type, "limit": 8};

      final result = await http.post(Uri.parse(_URL),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'});
      
      final jsonData = json.decode(result.body);          
      
    if(jsonData['alerts']['LastEvaluatedKey']==null){
   if (jsonData['ok'] == true) {
        final data =      NotMoreAlerts.fromJson(jsonData['alerts'] as Map<String, dynamic>);
        alertItems = data.items!;
        // lastEvaluatedKey = data.lastEvaluatedKey!.createdAt!;
        
      } 
    }else{
         if (jsonData['ok'] == true) {
        final data =      Alerts.fromJson(jsonData['alerts'] as Map<String, dynamic>);
        alertItems = data.items!;
        lastEvaluatedKey = data.lastEvaluatedKey!.createdAt!;
        
      }
    }

    }
    // alertItems = [];

    } catch (e) {
      Future.error(e);
    }
    return [alertItems, lastEvaluatedKey];
  }
}
