import 'package:abs_task/core/SideBar.dart';
import 'package:abs_task/core/Note_bottom_sheet.dart';
import 'package:abs_task/core/dialog_utils.dart';
import 'package:abs_task/core/my_colors.dart';
import 'package:abs_task/features/home/cubit/homeStates.dart';
import 'package:abs_task/features/home/cubit/homeViewModel.dart';
import 'package:abs_task/features/notes/cubit/NoteStates.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:abs_task/features/notes/view/noteswidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    // viewModel.getAllNotes();

    return Scaffold(
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
                borderRadius: BorderRadius.circular(10),
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
            icon: Icon(CupertinoIcons.profile_circled,size: 35,),
          ),
        ],
      ),
      body:Container(
        color: Colors.grey[50],
        child: Row(
          children: [
            SideBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back,",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text("You have  notes in your workspace"),
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
                      child: BlocBuilder<HomeViewModel, HomeStates>(
                        bloc: HomeViewModel.get(context)..getAllNotes(),
                        builder: (context, state) {
                          if (state is getNotesloadingStateHomeState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state
                              is getNoteserrorStateHomeState) {
                            print(state.error.toString());
                            return Center(child: Text(state.error.toString()));
                          } else if (state
                              is getNotessuccesStateHomeState) {
                            final notes = state.noteModel;
                            if (notes.isEmpty) {
                              return Center(
                                child: Text("No notes found"),
                              );
                            }

                            return GridView.builder(
                              scrollDirection: Axis.horizontal,

                              itemCount: notes.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 35.w,
                                    mainAxisSpacing: 35.h,
                                    childAspectRatio:0.6,
                                  ),
                              itemBuilder: (context, index) {
                                return NoteWidget(note: notes[index]);
                              },
                            );
                          } else {
                            return SizedBox();
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

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => NoteBottomSheet(methodName: "add"),
          );
          // HomeViewModel.get(context)..getAllNotes();
        },
        child: Icon(CupertinoIcons.add, color: AppColors.primaryColor),
      ),
    );
  }
}
