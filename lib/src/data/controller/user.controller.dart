




import 'package:push_notificaction/src/data/model/user-model.dart';
import 'package:push_notificaction/src/data/services/connect-with-api-user.dart';

class ControllerUser {

  ApiUser _apiUser = ApiUser();
Future addUser(UserModel user) async{
  try {      
      
        await _apiUser.addUser(user);               
    
      
  }catch(e){
      Future.error('ViewModelUser AddUser ERROR:  $e');
  }
}

Future<UserModel> getUserById(String id) async {
    UserModel dataUser = UserModel();
    final d = await _apiUser.getUserById(
        id); //Obtiene los datos del usuario por id, de la conexion realizada en ApiUser
    dataUser = UserModel.fromJson(d.data() as Map<String, dynamic>); //Convierte los datos recuperados de firebase en un objeto tipo User      
    return dataUser;
  }

}