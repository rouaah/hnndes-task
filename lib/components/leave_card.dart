import 'package:flutter/material.dart';
import 'package:hnndestask/components/app_list_tile.dart';
import 'package:hnndestask/constant/app_colors.dart';
import 'package:hnndestask/models/leave_model.dart';

class LeaveCard extends StatelessWidget {
  LeaveCard({Key? key,required this.leave}) : super(key: key);
  Leave leave;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      // AppColor.whiteColor,
      child: Column(
        children: [
          AppListTile(icon: Icons.date_range_outlined,title: 'Applied Duration',subtitle: '${leave.absenceFrom} to ${leave.absenceTo} ',color: Colors.pinkAccent.withOpacity(0.2),),
          AppListTile(icon: Icons.shopping_bag_outlined,title: 'Types of Leave',subtitle: leave.absenceValue,color: Colors.purpleAccent.withOpacity(0.2),),
          AppListTile(icon: Icons.message_outlined,title: 'Notes',subtitle: leave.notes ?? 'no Notes',color: Colors.blueAccent.withOpacity(0.2),),
          AppListTile(icon: Icons.warning_amber,title: 'Status',subtitle: leave.statusName,color: Colors.amberAccent.withOpacity(0.2),),
        ],
      ),
    );
  }
}
