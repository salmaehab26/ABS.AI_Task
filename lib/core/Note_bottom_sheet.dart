import 'package:abs_task/core/dialog_utils.dart';
import 'package:abs_task/features/home/cubit/homeStates.dart';
import 'package:abs_task/features/home/cubit/homeViewModel.dart';
import 'package:abs_task/features/home/model/homeFirebase.dart';
import 'package:abs_task/features/notes/cubit/NotesViewModel.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteBottomSheet extends StatelessWidget {
  NoteBottomSheet({required this.methodName, this.id });
  String? id ;
  // Function method;
  String methodName;
  DateTime selectedDate = DateTime.now();

  var formKey = GlobalKey<FormState>();

  String title = '';

  String description = '';

  // HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: HomeViewModel.get(context),
      listener: (context, state) {
        if (state is addNoteloadingStateHomeState)
          CircularProgressIndicator();
        else if (state is addNoteerrorStateHomeState)
          DialogUtil.showMessage(context, state.error.toString());
        else if (state is addNotesuccesStateHomeState)
          DialogUtil.showMessage(context, "note addes succesfully");
      },
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text('Add new Note'),
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
                          return 'Please enter Note title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'Enter Note Title'),
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
                          return 'Please enter Note description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Note Description',
                      ),
                      maxLines: 4,
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        NoteModel note = NoteModel(
                          title: title,
                          description: description,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          id: id
                        );
                        if (methodName == "add") {
                          HomeViewModel.get(context).addNote(note);
                        }
                        if (methodName == "update") {
                          NoteViewModel.get(context).updatenote(note);
                        }
                      }

                      Navigator.pop(context);
                    },
                    child: Text(methodName),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
