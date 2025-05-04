import 'package:abs_task/core/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return
        Container(
          width: 200,
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              ListTile(
                leading: Icon(Icons.dashboard, color: AppColors.primaryColor),
                title: Text(
                  'Dashboard',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                onTap: () {},
              ), ListTile(
                leading: Icon(Icons.note_add_outlined, color: AppColors.primaryColor),
                title: Text(
                  'My Notes',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.share, color: AppColors.primaryColor),
                title: Text(
                  'share with me ',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                onTap: () {},
              ),

              ListTile(
                leading: Icon(Icons.logout, color: AppColors.primaryColor),
                title: Text(
                  'Logout',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                onTap: () {
                  print('Logout tapped');
                },
              ),
            ],
          ),
        );
  }
}
