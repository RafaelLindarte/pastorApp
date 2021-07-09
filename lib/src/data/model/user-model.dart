

class UserModel {
    UserModel({
    this. id ='',    
    this. correo='',    
    this. nickname='',
    this. token='',
    
    });

    String id;    
    String correo;        
    String nickname;      
    String token;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id:                json["id"],
        correo:            json["correo"],        
        nickname:          json["nickname"],   
        token:             json["token"],   

      );

    Map<String, dynamic> toJson() => {                 
        "correo":            correo,      
        "id":                id,
        "nickname":          nickname,
        "token":             token,      
};
}