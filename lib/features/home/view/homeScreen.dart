import 'package:abs_task/core/SideBar.dart';
import 'package:abs_task/core/add_task_bottom_sheet.dart';
import 'package:abs_task/core/my_colors.dart';
import 'package:abs_task/features/home/cubit/homeViewModel.dart';
import 'package:abs_task/features/notes/cubit/NoteStates.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:abs_task/features/notes/view/noteswidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeViewModel viewModel = homeViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        viewModel.getAllNotes();
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            "CollabNotes",
            style: TextStyle(color: AppColors.primaryColor),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(60.w, 30.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(children: [Text("Go premium")]),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.profile_circled),
            ),
          ],
        ),
        body: Row(
          children: [
            SideBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back, Emily Johnson"),
                    Text("You have 12 notes in your workspace"),
                    SizedBox(height: 30.h),
                    Container(
                      width: 200.w,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          isDense: true,
                          hintText: "search notes..",
                          hintStyle: TextStyle(color: AppColors.greyColor),
                          focusColor: AppColors.primaryColor,
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: BlocBuilder<homeViewModel, NoteStates>(
                        builder: (context, state) {
                          if (state is loadingStateNoteState) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is succesStateNoteState) {
                            List<NoteModel> notes = state.noteModel;
                            return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: notes.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                              ),
                              itemBuilder: (context, index) {
                                return NoteWidget(note: notes[index]);
                              },
                            );
                          } else {
                            return Center(child: Text("No notes found"));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton( onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Optional: if you want full screen
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => AddTaskBottomSheet(),
          );
        },
          child: Icon(CupertinoIcons.add, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
