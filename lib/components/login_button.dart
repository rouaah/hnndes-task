import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hnndestask/constant/app_colors.dart';
import 'package:hnndestask/constant/app_sizes.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {Key? key,
        required this.onTap,
        required this.buttonText,
        this.btnWidth,
        this.btnHeight,
        this.isLoading,
      })
      : super(key: key);
  Function() onTap;
  String buttonText;
  double? btnWidth;
  double? btnHeight;
  bool? isLoading=false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth ?? AppSizes.safeBlockHorizontal * 60,
      height: btnHeight ?? AppSizes.safeBlockVertical*6,
      child: ElevatedButton(
        onPressed: onTap,
        child:isLoading==true ? CircularProgressIndicator(color: AppColor.whiteColor,)
              :Text(buttonText,
            style: TextStyle(color:AppColor.whiteColor,fontWeight: FontWeight.w800,fontSize: AppSizes.screenWidth*0.04)),
        style: ElevatedButton.styleFrom(
          // elevation: 2,
          padding: EdgeInsets.all(AppSizes.screenHeight * 0.01),
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),

        ),
      ),
    );
  }
}
