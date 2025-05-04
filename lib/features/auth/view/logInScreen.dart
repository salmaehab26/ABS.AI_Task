import 'package:abs_task/core/AppRoutes.dart';
import 'package:abs_task/core/dialog_utils.dart';
import 'package:abs_task/core/my_colors.dart';
import 'package:abs_task/core/text_field_item.dart';
import 'package:abs_task/features/auth/cubit/AuthState.dart';
import 'package:abs_task/features/auth/cubit/AuthViewModel.dart';
import 'package:abs_task/features/auth/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var loginViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: loginViewModel,
      listener: (context, state) {
        if (state is loadingStateUserState) {
          return DialogUtil.showLoading(context, "Loading...");
        } else if (state is errorStateUserState) {
          DialogUtil.hideLoading(context);
          return DialogUtil.showMessage(
            context,
            state.error.toString(),
            title: "Error",
          );
        } else if (state is succesStateUserState) {
          DialogUtil.hideLoading(context);
          Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ABS.AI Notes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome back! Please login to your account.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Container(
                  width: 300.w,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: loginViewModel.emailController,
                        borderColor: AppColors.primaryColor,

                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(height: 16),
                      CustomTextFormField(
                        borderColor: AppColors.primaryColor,
                        controller: loginViewModel.passwordController,
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    loginViewModel.login(
                      loginViewModel.emailController.text,
                      loginViewModel.passwordController.text,
                    );
                  },
                  child: Text('Log In'),
                ),
                SizedBox(height: 16),
                Text('Or'),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: Text('Do not have an account? Register now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
