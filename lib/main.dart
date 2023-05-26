import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnndestask/constant/app_sizes.dart';
import 'package:hnndestask/logic/cubit/app_cubit.dart';
import 'package:hnndestask/logic/cubit/auth_cubit.dart';
import 'package:hnndestask/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(sp)..getTokenFromSP(),
        ),
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(sp),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',
        useMaterial3: true,
      ),
      home: LogInScreen(),
    );
  }
}
