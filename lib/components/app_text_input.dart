import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnndestask/constant/app_colors.dart';
import 'package:hnndestask/constant/app_sizes.dart';
import 'package:hnndestask/logic/cubit/auth_cubit.dart';

class AppTextInput extends StatelessWidget {
  AppTextInput(
      {Key? key,
      this.isPassword,
      this.width,
        this.validator,
      this.controller})
      : super(key: key);
  bool? isPassword = false;
  double? width;
  final TextEditingController? controller;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(left:AppSizes.safeBlockHorizontal*8,right: AppSizes.safeBlockHorizontal*2),
        width: width ?? AppSizes.safeBlockHorizontal * 80,
        child: TextFormField(
          obscureText:isPassword==true && BlocProvider.of<AuthCubit>(context).ispasswordVisablitiy,
          cursorColor: AppColor.primaryColor,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              fillColor: Colors.white,
              // isDense: true,
              suffixIcon: isPassword ?? false
                  ?  IconButton(
                  icon: BlocProvider.of<AuthCubit>(context).ispasswordVisablitiy ==false
                      ? Icon(Icons.visibility , color:AppColor.primaryColor,)
                      : Icon(Icons.visibility_off , color: AppColor.primaryColor,),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).changePasswordVisibility();
                  })
                  : Container(width: 0),
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: new BorderSide(
                  color:AppColor.primaryColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20),
              )

          ),
        ));
  }
}
