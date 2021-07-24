import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:push_notificaction/src/data/model/modelo-tarjetas-alertas.dart';
import 'package:push_notificaction/src/data/model/user-model.dart';

import 'package:push_notificaction/src/shared/preferences.dart';
import 'package:diacritic/diacritic.dart';

class USerProvider {
  String url =
      'https://7nuyrr9ca3.execute-api.us-east-1.amazonaws.com/dev/controllerUsers';
  // ignore: non_constant_identifier_names
  String URL2 =
      'https://7nuyrr9ca3.execute-api.us-east-1.amazonaws.com/dev/controllerNotifications';

  final preferences = Preferences();
  Future<User> getUser() async {
    User dataUserModel = User();
    try {
      final body = {"action": "getUser", "email": preferences.uId.trim()};
      //solictando datos del usuario
      final response = await http.post(Uri.parse(url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'});

      final result = json.decode(response.body);
      dataUserModel.lastName = result['user']['lastName'];
      dataUserModel.firstName = result['user']['firstName'];
      print(dataUserModel.firstName);
    } catch (e) {
      print(e);
    }
    return dataUserModel;
  }

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

      final jsonData = json.decode(response.body);
      if (jsonData['ok'] == true) {
        message = 'ok';
      }
    } catch (e) {
      print('UserProvider addUser ERROR: $e');
    }
    return message;
  }

  Future<List<AlertModel>> getAllAlertByUserId() async {
    List<AlertModel> listAlert = [];

    try {
      final body = {"action": "getUser", "email": preferences.uId.trim()};
      //solictando datos del usuario
      final response = await http.post(Uri.parse(url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'});

      final result = json.decode(response.body);

      Map<String, dynamic> dataAlert = result['user']['subscriptions'];

      dataAlert.forEach((key, value) {
        final f = {'key': key, 'value': value};
        final ff = AlertModel.fromJson(f);
        listAlert.add(ff);
      });
    } catch (e) {
      print(e);
    }

    return listAlert;
  }

  Future<String> updateName(String firstName) async {
    String message = '';
    try {
      if (firstName != '' || firstName != null) {
        print(preferences.uId);
        final body1 = {
          "action": "updateUser",
          "email": preferences.uId,
          "updateKey": "firstName",
          "updateValue": removeDiacritics(firstName.trim())
        };
        final result = await http.post(Uri.parse(url),
            body: json.encode(body1),
            headers: {'Content-Type': 'application/json'});
        final data = json.decode(result.body);
        if(data['ok']){
          message = 'ok';
        }
      }
    } catch (e) {
      print(e);
    }
    return message;
  }

  Future<String> updateLastName(String lastName) async {
    String message = '';
    try {
      if (lastName != '' || lastName != null) {
        final body2 = {
          "action": "updateUser",
          "email": preferences.uId,
          "updateKey": "lastName",
          "updateValue": removeDiacritics(lastName.trim())
        };
        final result1 = await http.post(Uri.parse(url),
            body: json.encode(body2),
            headers: {'Content-Type': 'application/json'});
       final data = json.decode(result1.body);
        if(data['ok']){
          message = 'ok';
        }
      }
    } catch (e) {
      print(e);
    }
    return message;
  }

  Future<void> inactive(String arn, String key) async {
    try {
      print(arn);
      print(key);
      final body1 = {
        "action": "unsubscribeDeviceToTopic",
        "subscriptionArn": arn
      };
      await http.post(Uri.parse(URL2),
          body: json.encode(body1),
          headers: {'Content-Type': 'application/json'});
      final body2 = {
        "action": "updateUser",
        "email": preferences.uId.toString().trim(),
        "updateKey": "subscriptions",
        "subscriptionName": key.trim(),
        "status": "Inactive",
        "subscriptionArn": "No-arn"
      };
      await http.post(Uri.parse(url),
          body: json.encode(body2),
          headers: {'Content-Type': 'application/json'});
      print('222');
    } catch (e) {
      print(e);
      Future.error(e);
    }
  }

  Future<void> active(String type, String key) async {
    try {
      final body = {"action": "getUser", "email": preferences.uId.trim()};

      final response = await http.post(Uri.parse(url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'});

      final result = json.decode(response.body);

      final endpointARN = result['user']['endpointArn'];

      final body2 = {
        "action": "subscribeDeviceToTopic",
        "type": type,
        "endpointARN": endpointARN.toString().trim()
      };
      final result2 = await http.post(Uri.parse(URL2),
          body: json.encode(body2),
          headers: {'Content-Type': 'application/json'});
      final jsonData = json.decode(result2.body);
      final subscriptionARN = jsonData['newSub']['SubscriptionArn'];
      print(subscriptionARN);

      final body3 = {
        "action": "updateUser",
        "email": preferences.uId.trim(),
        "updateKey": "subscriptions",
        "subscriptionName": key,
        "status": "Active",
        "subscriptionArn": subscriptionARN
      };

      await http.post(Uri.parse(url),
          body: json.encode(body3),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print(e);
    }
  }

  Future<String> createAler(String name, String type) async {
    String message = '';
    try {
      final body = {
        "action": "registerSubscription",
        "email": preferences.uId,
        "name": name,
        "type": type,
        "status": "Active"
      };

      final response = await http.post(Uri.parse(url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'});

      final jsonData = json.decode(response.body);
      if (jsonData['ok'] == true) {
        message = 'ok';
      }
    } catch (e) {
      print(e);
    }

    return message;
  }
}
