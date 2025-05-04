import 'package:abs_task/features/auth/cubit/AuthState.dart';
import 'package:abs_task/features/auth/model/LoginFirebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthViewModel extends Cubit<UserStates> {
  AuthViewModel() : super(initStateUserState());
  var formKey=GlobalKey<FormState>();
   var emailController=TextEditingController();
   var passwordController=TextEditingController();
  static  bool isObscure=true;
    login(String email, String password) async {

    Future<void> login(String email, String password) async {
    emit(loadingStateUserState());

    try {
    await FirebaseLogin.login(email, password);
    emit(succesStateUserState());
    } catch (e) {
    emit(errorStateUserState(error: e.toString()));
    }
}}}
