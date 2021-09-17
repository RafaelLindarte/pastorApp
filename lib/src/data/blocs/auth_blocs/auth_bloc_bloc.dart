import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocInitial());

StreamController<String> _userConroler = StreamController<String>.broadcast();
StreamController<String> _passwordController = StreamController<String>.broadcast();

Stream<String> get emailController => _userConroler.stream;
Stream<String> get passController => _passwordController.stream;

void dispose(){
_userConroler.close();
_passwordController.close();
}
  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    if(event is InputUser){      
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp re = new RegExp(pattern.toString());
    if(re.hasMatch(event.user)){      
        _userConroler.sink.add(event.user);
        
      }else{        
        _userConroler.addError('El usuario no es un email valido');
      }
    }else if(event is InputPass){
      Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
      RegExp re = new RegExp(pattern.toString());
       if(re.hasMatch(event.pass)){      
        _passwordController.sink.add(event.pass);
      }else{        
        _passwordController.addError('Debe tener letras y numeros');
      }    
      }
  }


}
