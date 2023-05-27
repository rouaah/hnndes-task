import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hnndestask/components/annual_leaves_curve.dart';
import 'package:hnndestask/components/leave_card.dart';
import 'package:hnndestask/constant/app_colors.dart';
import 'package:hnndestask/constant/app_sizes.dart';
import 'package:hnndestask/logic/cubit/app_cubit.dart';
import 'package:hnndestask/logic/cubit/auth_cubit.dart';
import 'package:hnndestask/logic/states/app_states.dart';
import 'package:hnndestask/models/user_model.dart';
import 'package:hnndestask/screens/login.dart';

class LeavesScreen extends StatelessWidget {
  const LeavesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: Text('My Leaves'),
        centerTitle: true,
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) async {
          if (BlocProvider.of<AppCubit>(context).requirLogin) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogInScreen(),
                ));

            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("something went wrong"),
                    content: Text("sorry , you need to logIn again"),
                    actions: <Widget>[
                      TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ],
                  );
                });
          }
        },
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          UserModel? user = BlocProvider.of<AuthCubit>(context).user;
          return appCubit.isLoadingFirstLeaves || appCubit.isLoadingLeaveCount
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                )
              : appCubit.isError
                  ? Container(
                      child: Center(
                        child: Text('something went wrong'),
                      ),
                    )
                  : SingleChildScrollView(
                      controller: appCubit.scrollController
                        ..addListener(() async {
                          await appCubit.getLeavesListMoreLoad(
                              user!.employee!.company.companyId,
                              user.employee!.department.departmentId,
                              user.employee!.employeeId);
                        }),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnnualLeavesCurve(
                            userName: BlocProvider.of<AuthCubit>(context)
                                    .user!
                                    .username ??
                                '',
                            leaveCount: appCubit.leavesNumber,
                            maxLeaves: appCubit.leaveCount.maxAnnual,
                          ),
                          ListView.builder(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: appCubit.leaves.length,
                              // appCubit.leaves.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return LeaveCard(
                                  leave: appCubit.leaves[index],
                                );
                              }),
                          appCubit.isLoadMoreRunning
                              ? Container(
                                  height: AppSizes.screenHeight * 0.07,
                                  color: AppColor.backgroundColor,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColor.primaryColor,
                                    ),
                                  ))
                              : appCubit.hasNextPage == false
                                  ? Container(
                                      height: AppSizes.screenHeight * 0.05,
                                      color: AppColor.backgroundColor,
                                      child: Center(
                                          child: Text(
                                              'you have fetched all of the content')),
                                    )
                                  : appCubit.isErrorFechingNewData
                                      ? Container(
                                          height: AppSizes.screenHeight * 0.05,
                                          color: AppColor.backgroundColor,
                                          child: Center(
                                              child: Text(
                                                  'something went wrong , please try again')),
                                        )
                                      : Container()
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
