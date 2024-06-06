import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_state.dart';
import 'package:uber_eats_clone/data/models/user_model.dart';
import 'package:uber_eats_clone/data/repositories/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(UserLoggedInState(firebaseUser: currentUser));
    } else {
      emit(UserLoggedOutState());
    }
  }
  final UserRepository _userRepository = UserRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  void sendOtp(String phoneNumber) async {
    emit(UserLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(UserCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(UserErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOtp(String otp) async {
    emit(UserLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        emit(UserLoggedInState(firebaseUser: userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(UserErrorState(e.message.toString()));
    }
  }

  void createAccount({
    required String email,
    required String fullName,
    required String phoneNumber,
    String? address,
  }) async {
    try {
      UserModel userModel = await _userRepository.createAccount(
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address,
      );
      log('Account created successfully.');
      emit(UserDetailsCreatedState(userModel));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<bool> checkUserExist({
    required String phoneNumber,
  }) async {
    emit(UserLoadingState());
    try {
      bool response = await _userRepository.checkUserExist(
        phoneNumber: phoneNumber,
      );
      log(response.toString());
      emit(UserLoadedState());
      return response;
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
    return false;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(UserLoggedOutState());
  }
}
