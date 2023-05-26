import 'package:flutter/material.dart';
import 'package:hnndestask/constant/app_colors.dart';

class AppListTile extends StatelessWidget {
   AppListTile({Key? key,required this.icon,required this.title,required this.subtitle,required this.color}) : super(key: key);
  IconData icon;
  String title;
  String subtitle;
  Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(icon),backgroundColor: color),
      title: Text(title,style: TextStyle(color: AppColor.greyColor),),
      subtitle: Text(subtitle ,style: TextStyle(color: AppColor.secondaryColor),),

    );
  }
}
