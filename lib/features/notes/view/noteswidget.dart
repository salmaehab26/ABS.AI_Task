import 'package:abs_task/core/my_colors.dart';
import 'package:abs_task/features/home/cubit/homeViewModel.dart';
import 'package:abs_task/features/notes/cubit/NotesViewModel.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteWidget extends StatefulWidget {
   NoteWidget({super.key,required this.note});
NoteModel note;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {


  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return Container(
      height: 100.h,
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.note.title!,style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold ),),
                Container(
                  child: Row(
                    children: [
                      IconButton(onPressed: () {
                        viewModel.deleteNote(widget.note.id!
                        );
                      }, icon: Icon(CupertinoIcons.delete,color: AppColors.greyColor,size:15 ,)
                      ),  IconButton(onPressed: () { }, icon: Icon(Icons.edit,color: AppColors.greyColor,size:15 ,)
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(widget.note.description!)
          ],
        ),
      ),
    );
  }
}
