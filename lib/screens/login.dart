import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnndestask/components/app_text_input.dart';
import 'package:hnndestask/components/login_button.dart';
import 'package:hnndestask/constant/app_colors.dart';
import 'package:hnndestask/constant/app_sizes.dart';
import 'package:hnndestask/logic/cubit/app_cubit.dart';
import 'package:hnndestask/logic/cubit/auth_cubit.dart';
import 'package:hnndestask/logic/states/app_states.dart';
import 'package:hnndestask/logic/states/auth_states.dart';
import 'package:hnndestask/screens/leaves_screen.dart';
import 'package:hnndestask/utils/form_keys.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit authCubit = AuthCubit.get(context);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit appCubit = AppCubit.get(context);
            return Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: SingleChildScrollView(
                child: Form(
                  key: MyKeys.loginFormKey,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: AppSizes.screenHeight * 0.2,
                        ),
                        Image(
                            image: ResizeImage(
                                AssetImage('assets/images/login_image.png'),
                                width: 300,
                                height: 300)),
                        // Image.asset('assets/images/login_image.png',width: double.infinity,),
                        SizedBox(
                          height: AppSizes.screenHeight * .05,
                        ),
                        Text(
                          'Please Login To Your Account',
                          style: TextStyle(
                              color: AppColor.secondaryColor,
                              fontFamily: 'Cairo-Bold',
                              fontWeight: FontWeight.w600,
                              fontSize: AppSizes.screenWidth * 0.04),
                        ),
                        SizedBox(
                          height: AppSizes.screenHeight * 0.05,
                        ),
                        SizedBox(
                            width: AppSizes.screenWidth * 0.8,
                            child: Text(
                              'userName / Email',
                              style: TextStyle(
                                  fontFamily: 'Cairo-SemiBold',
                                  fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: AppSizes.screenHeight * 0.01,
                        ),
                        AppTextInput(
                          controller: authCubit.userNameController,
                          validator: (val) {
                            val = authCubit.userNameController.text;
                            if (val.isEmpty) {
                              return 'username can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: AppSizes.screenHeight * 0.02,
                        ),
                        SizedBox(
                            width: AppSizes.screenWidth * 0.8,
                            child: Text(
                              'password',
                              style: TextStyle(
                                  fontFamily: 'Cairo-SemiBold',
                                  fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: AppSizes.screenHeight * 0.01,
                        ),
                        AppTextInput(
                            controller: authCubit.passwordController,
                            isPassword: true,
                            validator: (val) {
                              val = authCubit.passwordController.text;
                              if (val.isEmpty) {
                                return 'please enter password';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: AppSizes.screenHeight * 0.06,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //   Text('remember me'),
                        //   SizedBox(width: AppSizes.screenWidth*0.1),
                        //   Text('forgot password'),
                        // ],),
                        // SizedBox(height: AppSizes.screenHeight*0.02,),
                        AppButton(
                          onTap: () async {
                            print('hello log btn');
                            if (MyKeys.loginFormKey.currentState!.validate()) {
                              bool isLoggedIn = await authCubit.login();
                              print(isLoggedIn);
                              if (isLoggedIn) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LeavesScreen(),
                                    ));
                                await appCubit.getLeaveCount(
                                    authCubit.user!.employee!.employeeId,context);
                                await appCubit.getLeavesListFirstLoad(
                                    authCubit.user!.employee!.company.companyId,
                                    authCubit.user!.employee!.department
                                        .departmentId,
                                    authCubit.user!.employee!.employeeId);
                              } else {
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                  title: Text("something went wrong"),
                                  content: Text("please make sure your email / password is valid"),
                                  actions: <Widget>[
                                   TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                  Navigator.of(context).pop();
                                  },
                                  ),
                                  ],
                                  );
                                });
                              }
                            }
                          },
                          buttonText: 'LogIn',
                          isLoading: authCubit.isLoadingLogin,
                          btnWidth: AppSizes.screenWidth * 0.8,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
