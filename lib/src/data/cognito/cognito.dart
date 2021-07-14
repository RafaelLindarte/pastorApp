import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class Cognito {
  final _userPool = CognitoUserPool(
    'us-east-1_ACURJmxp4',
    '3if8rq6er825l3rnl9csfj4e3h',
  );

  Future<String> singUp(
      String email, String passw, String conf, String name) async {
    String message = '';
    if (email == '' || passw == '' || name == '') {
      message = 'Por favor llene todos los campos';
    } else if (passw.length < 8) {
      message = 'La contraseña debe tener más de 8 caracteres';
    } else if (passw != conf) {
      message = 'Contraseñas no coinciden';
    } else {
      try {
        final userAttributes = [
          AttributeArg(name: 'email', value: email),
          AttributeArg(name: 'name', value: name)
        ];

        final result =
            await _userPool.signUp(email, passw, userAttributes: userAttributes);
        if (result.user != null) {
          print(result.user);
          message = 'ok';
        }
        print(message);
      } catch (e) {
        print('Cognito SingUP Error $e');
        return '${Future.error(e)}';
      }
    }
    return message;
  }
}
