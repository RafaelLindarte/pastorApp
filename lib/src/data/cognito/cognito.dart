



import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:push_notificaction/src/data/provider/user-provider.dart';
import 'package:push_notificaction/src/shared/preferences.dart';

class Cognito {
  final _userPool = CognitoUserPool(
    'us-east-1_ACURJmxp4',
    '3if8rq6er825l3rnl9csfj4e3h',
  );
  final _preferences = Preferences();



Future<String> singIn(String email, String pass) async{
String message = '';
  try{
    final cognitoUser = CognitoUser(email, _userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: pass,
    );
    CognitoUserSession? session = await cognitoUser.authenticateUser(authDetails);
    if(session!.getAccessToken().getJwtToken()!=null){

      message = 'ok';
      _preferences.uid = email;
    }
  }catch(e){
      message = 'Usuario y/o contraseña no son correctos';
      print(e);
  }
  return message;
}


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

        final result = await _userPool.signUp(email, passw,
            userAttributes: userAttributes);
        if (result.user != null) {
          _preferences.uid = email;
          message = 'ok';
        }
        print(message);
      } on CognitoClientException {                
          message = 'La contraseña debe por lo menos una letra miniscula';        

      }
       catch (e) {
        print('Cognito SingUP Error $e');
        return '${Future.error(e)}';
      }
    }
    return message;
  }

  Future<bool> confirEmail(String codigo) async {
    bool registrationConfirmed = false;
    final uSerProvider= USerProvider();
      
    final cognitoUser = CognitoUser(_preferences.uId, _userPool);

    try {
      registrationConfirmed =
          await cognitoUser.confirmRegistration(codigo.trim());
      if(registrationConfirmed) {
         final result = await uSerProvider.addUser(_preferences.nombre,_preferences.apellido , _preferences.uId, _preferences.token);
         if(result == 'ok'){
            _preferences.clearInfoRegistro();
         }
      }
          print(registrationConfirmed);
    } catch (e) {
      print('2222');
      print(e);
    }
    return registrationConfirmed;
  }



  Future<String> enviarCodigo(String email) async{
    String message = '';
    try{
        if(email.trim() ==''){
          message  = 'Por favor ingrese un correo electronico';
        }else{
              final cognitoUSer =CognitoUser(email.trim(), _userPool);
        final send =      await cognitoUSer.forgotPassword();
        if(send!=null){
          message = 'ok';
        }

          }
    }catch(e){
        print(e);
        message = 'error, intente nuevamente';
    }
    return message;

  }

  Future<String> changePassword(String  email, String code, String password) async{
    String message = '';
    try{
        if(code.trim()== ''){
          message = 'Por favor ingrese el código';
        }else if(password.trim().length<8){
            message = 'La contraseña debe tener más de 8 caracteres';                        
        }else{
              final cognitoUSer =CognitoUser(email.trim(), _userPool);

          bool confirmPassword = await cognitoUSer.confirmPassword(code, password);
          if(confirmPassword){
            message = 'ok';
          }
        }
    }catch(e){
      print(e);
      message = 'error, intente nuevamente';
    }
    
    
    return message;

  }



}
