import 'package:flutter/material.dart';
import 'package:hnndestask/components/custom_clipper.dart';
import 'package:hnndestask/constant/app_colors.dart';
import 'package:hnndestask/constant/app_sizes.dart';

class AnnualLeavesCurve extends StatelessWidget {
   AnnualLeavesCurve({Key? key , required this.userName,required this.leaveCount,required this.maxLeaves}) : super(key: key);
  String userName;
  int leaveCount;
  double maxLeaves;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        padding: EdgeInsets.all(25),
        color: AppColor.primaryColor.withOpacity(0.5),
        height: AppSizes.screenHeight*0.25,
        child: Column(
          children: [
          Container(
              margin: EdgeInsets.all(5),
              child: SizedBox(width: AppSizes.screenWidth,child: Text(userName,style: TextStyle(color: Colors.white),))),
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(value: leaveCount/maxLeaves ,minHeight: 15,color: Colors.red.shade800,)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('$leaveCount leaves',style: TextStyle(color: Colors.white),),
              SizedBox(width: AppSizes.screenWidth*0.1,),
              Text('$maxLeaves leaves',style: TextStyle(color: Colors.white),)],)
        ],),
      ),
    );
  }
}
