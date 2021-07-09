import 'package:firebase_auth/firebase_auth.dart';
import 'package:push_notificaction/src/data/controller/user.controller.dart';
import 'package:push_notificaction/src/data/model/user-model.dart';
import 'package:push_notificaction/src/shared/preferences.dart';

class LoginController {
//   AuthCredential credential;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _preferences = Preferences();
  Future<String> sigInWitEmeil(String user, String pass) async {
    String message = '';

    try {
      if (user == '' || pass == '') {
        message = 'Por favor llene todos los campos';
      } else if (pass.trim().length < 6) {
        message = 'la contraseña debe tener más de 6 caracteres';
      } else if (pass.trim() == '123456') {
        message = 'Contraseña no admitida';
      } else {
                    await _auth.signInWithEmailAndPassword(email: user, password: pass);                    
                    _preferences.uid =  _auth.currentUser!.uid;
        message = 'ok';
      }
      return message;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> createUser(String name, String email, String pass) async {
   UserModel user = UserModel();
   
   
     ControllerUser _controllerUser = ControllerUser();   
    String message;
    try{
      if(name=='' || email == '' || pass == ''){
            message = 'Campos vacios';
      }else if (pass.length < 6) {
        message = 'la contraseña debe tener más de 6 caracteres';
      } else if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email)) {
        message = 'el correo no es valido';
      }else{
            await _auth
                                              .createUserWithEmailAndPassword(
                                                email: email, 
                                                password: pass
                                                );              
        user.id       = _auth.currentUser!.uid;
        user.nickname = name;
        user.correo   = email;
        user.token  = _preferences.token;
        _preferences.uid =  _auth.currentUser!.uid;
        // prefs.userId  = _vl.auth.currentUser.uid;
        // prefs.typeSingIn = 'e';        
         _controllerUser.addUser(user);
        message = 'ok';
      }
      return message;
    } catch (e) {
      return Future.error(e);
    }
  }
}
