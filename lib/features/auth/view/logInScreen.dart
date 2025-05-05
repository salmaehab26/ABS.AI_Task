import 'package:abs_task/core/AppRoutes.dart';
import 'package:abs_task/core/my_colors.dart';
import 'package:abs_task/core/text_field_item.dart';
import 'package:abs_task/features/auth/cubit/AuthViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abs_task/features/auth/cubit/AuthState.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocListener<AuthViewModel, UserStates>(
        listener: (context, state) {
          if (state is succesStateUserState) {
            Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
          } else if (state is errorStateUserState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
              Text(
              'ABS.AI Notes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),),
                SizedBox(height: 8.h),
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
                        controller: emailController,
                        borderColor: AppColors.primaryColor,

                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(height: 16),
                      CustomTextFormField(
                        borderColor: AppColors.primaryColor,
                        controller: passwordController,
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
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    context.read<AuthViewModel>().login(email, password);

                  },
                  child: Text("Log In"),
                ),
            SizedBox(height: 16),
            Text('Or'),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: Text('Do not have an account? Register now'),
            ) ],
            ),
          ),
        ),
      ),
    );
  }
}
