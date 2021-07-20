import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:push_notificaction/src/shared/preferences.dart';

class USerProvider {
  String url =
      'https://7nuyrr9ca3.execute-api.us-east-1.amazonaws.com/dev/controllerUsers';
  // ignore: non_constant_identifier_names
  String URL2 =
      'https://7nuyrr9ca3.execute-api.us-east-1.amazonaws.com/dev/controllerNotifications';

  Future<String> addUser(
      String name, String lastName, String email, String token) async {
    String message = '';
    final body = {
      "action": 'createUser',
      "firstName": name,
      "lastName": lastName,
      "email": email,
      "deviceToken": token
    };

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'});
      print(response.body);
      final jsonData = json.decode(response.body);
      if (jsonData['ok'] == true) {
        message = 'ok';
      }
    } catch (e) {
      print('*****************');
      print('UserProvider addUser ERROR: $e');
    }

    return message;
  }

  Future<void> onOf() async {
    final preferences = Preferences();
    try {
      final body = {"action": "getUser", "email": preferences.uId.trim()};
      //solictando subscriptionArn del usuario
      final response = await http.post(Uri.parse(url),
          body: json.encode(body),
          headers: {
            'Content-Type': 'application/json'
          }); //TODO: Realizar modelo de datos
      final result = json.decode(response.body);

      //Guardando subscriptionArn del usuario en el controller de notificaciones
      if (result['user']['notificationStatus'] == 'Active') {
        String subscriptionArn = result['user']['subscriptionArn'];
        // ignore: unnecessary_null_comparison
        if (subscriptionArn != null) {
          final body2 = {
            "action": "unsubscribeDeviceToTopic",
            "subscriptionArn": subscriptionArn
          };
          await http.post(Uri.parse(URL2),
              body: json.encode(body2),
              headers: {'Content-Type': 'application/json'});

          final body3 = {//body para inctivar el status de las notficaciones
            "action": "updateUser",
            "email": preferences.uId.toString().trim(),
            "updateKey": "notificationStatus",
            "updateValue": "Inactive"
          };
          await http.post(Uri.parse(url), body: json.encode(body3), headers: {
            'Content-Type': 'application/json'
          }); //actualizando status: inactive
          final body4 = {//body para limpiar el suscriptionARN
            "action": "updateUser",
            "email": preferences.uId.toString().trim(),
            "updateKey": "subscriptionArn",
            "updateValue": "No-Arn"
          };
          await http.post(Uri.parse(url), body: json.encode(body4), headers: {
            'Content-Type': 'application/json'
          }); //actualizando subscriptionArn

        }
      } else {
        //para activar

        final body = {"action": "getUser", "email": preferences.uId.trim()};
        final result3 = await http.post(Uri.parse(url),
            body: json.encode(body),
            headers: {'Content-Type': 'application/json'}
            );        
        final data = json.decode(result3.body);        
        final body2 = {
          "action": "subscribeDeviceToTopic",
          "endpointARN": data['user']['endpointArn']
        };

        final result = await http.post(Uri.parse(URL2),
            body: json.encode(body2),
            headers: {'Content-Type': 'application/json'});//consulta para obtener SubscriptionArn
        final data2 = json.decode(result.body);        

        final body3 = {
          "action": "updateUser",
          "email": preferences.uId.toString().trim(),
          "updateKey": "notificationStatus",
          "updateValue": "Active"
        };//body para actualizar status
        await http.post(Uri.parse(url), body: json.encode(body3), headers: {
          'Content-Type': 'application/json'
        }); //actualizando status: Active
        final body4 = {
          "action": "updateUser",
          "email": preferences.uId.toString().trim(),
          "updateKey": "subscriptionArn",
          "updateValue": data2['newSub']['SubscriptionArn']
        };//body para actulizar SubscriptionArn
        await http.post(Uri.parse(url), body: json.encode(body4), headers: {
          'Content-Type': 'application/json'
        }); //Actualizando SubscriptionArn

      }
    } catch (e) {

      print(' UserProvider ON/OF ERROR: $e');
    }
  }
}
