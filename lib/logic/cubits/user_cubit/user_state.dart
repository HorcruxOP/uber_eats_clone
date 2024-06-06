import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_eats_clone/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserCodeSentState extends UserState {}

class UserCodeVerifiedState extends UserState {}

class UserLoadingState extends UserState {}
class UserLoadedState extends UserState {}

class UserLoggedInState extends UserState {
  final User firebaseUser;

  UserLoggedInState({required this.firebaseUser});
}

class UserLoggedOutState extends UserState {}

class UserDetailsCreatedState extends UserState {
  final UserModel usermodel;
  UserDetailsCreatedState(this.usermodel);
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
