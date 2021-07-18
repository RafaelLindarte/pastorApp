
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

SharedPreferences? _preferences;

static final Preferences _instancia = Preferences._internal();
    factory Preferences() {
    return _instancia;
  }
  Preferences._internal();
intPreferencrs() async{  
    _preferences = await SharedPreferences.getInstance();
}





set uid(String id){
  _preferences?.setString('uid', id);
}
set token(final token){  
  _preferences?.setString('token', token);  
}

set name (String name){
  _preferences?.setString('nombre', name);
}
set lastname (String lastname){
  _preferences?.setString('apellido', lastname);
}
set isWelcome(String iw){
  _preferences?.setString('bienvenido', iw);
}



  get token      => _preferences?.getString('token');
  get uId        => _preferences?.getString('uid');
  get nombre     => _preferences?.getString('nombre');
  get apellido   => _preferences?.getString('apellido');
  get iswelcome  => _preferences?.getString('bienvenido');


Future<void> clearInfoRegistro() async{
  await _preferences?.setString('nombre', '');
  await _preferences?.setString('apellido', '');    
}  
Future<void> clearPreferences() async{
  await _preferences?.setString('uid', '');
  

}
}



