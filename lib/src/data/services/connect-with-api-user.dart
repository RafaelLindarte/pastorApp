



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:push_notificaction/src/data/model/user-model.dart';



class  ApiUser {
// final preferences = Preferences();
 
 
    CollectionReference _ref = FirebaseFirestore.instance.collection('user');
  
  

  Future<void> addUser(UserModel user){
    // print(preferences.token);
    return _ref
              .doc(user.id)
              .set({
            "nickname":   user.nickname,
            "correo":     user.correo,
            "id":         user.id,
            "token":      user.token,
              });             
  }

    Future<DocumentSnapshot> getUserById(String id){
    return _ref.doc(id).get();
  }


}
 