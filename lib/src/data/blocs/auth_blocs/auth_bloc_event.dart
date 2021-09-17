part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocEvent {}

class InputUser extends AuthBlocEvent{
  final String user;
  
  InputUser(this.user);

}
class InputPass extends AuthBlocEvent{
  final String pass;  
  InputPass(this.pass);
}