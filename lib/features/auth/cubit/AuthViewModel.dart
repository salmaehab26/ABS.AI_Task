import 'package:abs_task/features/auth/cubit/AuthState.dart';
import 'package:abs_task/features/auth/model/LoginFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends Cubit<UserStates> {
  final FirebaseAuth firebaseAuth;

  AuthViewModel(this.firebaseAuth) : super(initStateUserState());

  Future<void> login(String email, String password) async {
    emit(loadingStateUserState());
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userId", userId);
      emit(succesStateUserState());
    } catch (e) {
      emit(errorStateUserState(e.toString()));
    }
  }}