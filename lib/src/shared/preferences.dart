
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
  get token => _preferences?.getString('token');
  get uId   => _preferences?.getString('uid');
  
Future<void> clearPreferences() async{
  await _preferences?.setString('uid', '');

}
}



