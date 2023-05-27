
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnndestask/helpers/dio_helper.dart';
import 'package:hnndestask/logic/states/app_states.dart';
import 'package:hnndestask/models/leave_count_model.dart';
import 'package:hnndestask/models/leave_model.dart';
import 'package:hnndestask/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppStates>{
  SharedPreferences sp;
  AppCubit(this.sp) : super(AppStatesInitalState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isLoadingLeaveCount=false;
  late LeaveCount leaveCount;
  int leavesNumber=0;

  int pageNumber=1;
  int pageSize=10;
  bool isLoadingFirstLeaves=false;
  bool hasNextPage=true;
  bool isLoadMoreRunning=false;
  bool isErrorFechingNewData=false;
  bool isError=false;
  bool requirLogin=false;

  List<Leave> leaves=[];

  ScrollController scrollController=ScrollController();

  Future<void> getLeaveCount(int employeeId,BuildContext context) async {
    try {
      isLoadingLeaveCount = true;
      emit(AppRefreshUIState());
      var response = await DioHelper.dio!.get(
        "Employee/LeaveCount/$employeeId",
      );
      if (response.statusCode == 200) {
        // leaveCounts.clear();
        print(response.data['data']);
        leaveCount = LeaveCount.fromJson(response.data["data"]);
        leavesNumber += leaveCount.marriage + leaveCount.unpaid+ leaveCount.others+ leaveCount.death+ leaveCount.workAccident+ leaveCount.maternity+ leaveCount.sickness+ leaveCount.annual ;
        isLoadingLeaveCount = false;
        emit(AppRefreshUIState());
      }else if(response.statusCode==401){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
      }
      else {
        isError = true;
        isLoadingLeaveCount = false;
        emit(AppRefreshUIState());
      }
    } catch (e) {
      isLoadingLeaveCount = false;
      isError=true;
      emit(AppRefreshUIState());
      print(e.toString());
    }
  }

  Future<void> getLeavesListFirstLoad(int companyId , int departmentId , int employeeId) async {
    try {
      isLoadingFirstLeaves = true;
      emit(AppRefreshUIState());
      var data = {
        'companyId': companyId,
        'departmentId': departmentId,
        'employeeId': employeeId,
        'pageNumber': pageNumber,
        'pageSize': 5,
      };
      print(data);
      var response = await DioHelper.dio!.get(
          "Leave/List",
          // data: jsonEncode(
          //   data,
          // ),
          options: Options(
              headers: data
          )
      );
      if (response.statusCode == 200) {
        leaves.clear();
        for (var leave in response.data["data"]["leaves"]) {
          leaves.add(Leave.fromJson(leave));
        }
        print(leaves);
        isLoadingFirstLeaves = false;
        isError = false;
        emit(AppRefreshUIState());
      } else {
        isError = true;
        isLoadingFirstLeaves = false;
        emit(AppRefreshUIState());
      }
    }catch (e) {
      isError = true;
      isLoadingFirstLeaves = false;
      emit(AppRefreshUIState());
      print(e.toString());
    }
  }

  Future<void> getLeavesListMoreLoad(int companyId , int departmentId , int employeeId,) async {
      if(hasNextPage==true && isLoadingFirstLeaves==false && isLoadMoreRunning==false && scrollController.position.extentAfter<300){
      isLoadMoreRunning = true;
      emit(AppRefreshUIState());
      pageNumber+=1;
      try {
        var data = {
          'companyId': companyId,
          'departmentId': departmentId,
          'employeeId': employeeId ,
          'pageNumber': pageNumber,
          'pageSize': 5,
        };
        print(data);
        var response = await DioHelper.dio!.get(
          "Leave/List",
          // data: jsonEncode(
          //   data,
          // ),
          options: Options(
              headers:data
          )
        );
        if (response.statusCode == 200) {
          List fetchedLeaves = response.data["data"]["leaves"];
          if (fetchedLeaves.isNotEmpty) {
            for (var leave in response.data["data"]["leaves"]) {
              leaves.add(Leave.fromJson(leave));
            }
            isErrorFechingNewData=false;
            emit(AppRefreshUIState());
          }
          else {
            hasNextPage = false;
            emit(AppRefreshUIState());
          }
          isLoadMoreRunning = false;
          emit(AppRefreshUIState());
        }
        else if(response.statusCode==401 ){
          isLoadMoreRunning=false;
          requirLogin=true;
          emit(AppRefreshUIState());
        }
        else{
          isErrorFechingNewData=true;
          emit(AppRefreshUIState());
        }
      }catch(e){
        isLoadMoreRunning = false;
        isErrorFechingNewData=true;
        emit(AppRefreshUIState());
        print(e);
      }
    }
  }


}