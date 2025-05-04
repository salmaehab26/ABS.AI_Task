

import 'package:abs_task/features/home/model/homeFirebase.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  // late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    // listProvider = Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'Add new Task',
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text) {
                      title = text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter task title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Enter Task Title'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text) {
                      description = text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter task description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Task Description',
                    ),
                    maxLines: 4,
                  ),
                ),


                ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  child: Text(
                    'Add',

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  void addTask()async {
    if (formKey.currentState?.validate() == true) {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        return;
      }
      NoteModel note = NoteModel(
        title: title,
        description: description,

      );
    NotesFirebase.addnoteToFireStore(note,userId);
    }
  }
}
