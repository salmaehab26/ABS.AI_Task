import 'package:abs_task/core/AppGenerator.dart';
import 'package:abs_task/core/AppRoutes.dart';
import 'package:abs_task/features/auth/cubit/AuthViewModel.dart';
import 'package:abs_task/features/home/cubit/homeViewModel.dart';
import 'package:abs_task/features/home/view/homeScreen.dart';
import 'package:abs_task/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(

      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthViewModel(FirebaseAuth.instance)),
          BlocProvider(create: (_) => HomeViewModel()),
        ],
        child: MyApp(),

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder: (context, child) {
        return MaterialApp(
          onGenerateRoute: RoutesGenerator.getRoutes,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.Login,
        );
      },
    );
  }
}
