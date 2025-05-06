import 'package:abs_task/core/Note_bottom_sheet.dart';
import 'package:abs_task/core/my_colors.dart';
import 'package:abs_task/features/home/cubit/homeViewModel.dart';
import 'package:abs_task/features/notes/cubit/NotesViewModel.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteWidget extends StatelessWidget {
  NoteWidget({super.key, required this.note});

  NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.title!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          NoteViewModel.get(context).deleteNote(note.id!);
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: AppColors.greyColor,
                          size: 15,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => NoteBottomSheet(methodName: 'update',id:note.id),
                          );

                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.greyColor,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h,),
            Text(note.description!),
          ],
        ),
      ),
    );
  }
}
