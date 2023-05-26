
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnndestask/helpers/dio_helper.dart';
import 'package:hnndestask/logic/states/auth_states.dart';
import 'package:hnndestask/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthStates> {
  SharedPreferences sp;
  AuthCubit(this.sp) : super(AuthStatesInitalState());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  UserModel? user;
  String? userId;
  String token = "";
  bool isLoadingLogin=false;

  bool ispasswordVisablitiy=true;

  void changePasswordVisibility(){
    ispasswordVisablitiy=!ispasswordVisablitiy;
    emit(AuthRefreshUIState());
  }

  Future<void> setTokenInSP(String tok) async {
    if (tok == "") {
      sp.clear();
    }
    token = tok;
    await sp.setString("token", token ?? "");
    DioHelper.init(token: this.token);
    emit(AuthRefreshUIState());
  }

  Future<void> getTokenFromSP() async {
    token = sp.getString("token") ?? "";
    if (token != "" && token != null) {
      // await refresh();
    }
    await setTokenInSP(token);
  }
  Future<bool> login() async {
    try {
      isLoadingLogin = true;
      emit(AuthLogInLoadingState());
      var data = {
        "username": userNameController.text,
        "password": passwordController.text,
      };
      print(jsonEncode(data));
      final response = await DioHelper.dio!.post("Auth/login", data: jsonEncode(data));
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        await setTokenInSP(response.data["data"]["accessToken"] as String);
        user=UserModel.fromJson(response.data['data']['user']);
        isLoadingLogin = false;
        emit(AuthLogInSuccessState());
        return true;
      } else {
        await setTokenInSP("");
        isLoadingLogin = false;
        emit(AuthLogInErrorState());
        return false;
      }
    } catch (e) {
      print(e);
      isLoadingLogin = false;
      emit(AuthLogInErrorState());
      return false;
    }
  }
}