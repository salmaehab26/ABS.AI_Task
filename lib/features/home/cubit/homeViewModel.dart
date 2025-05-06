import 'dart:async';
import 'dart:math';

import 'package:abs_task/features/home/cubit/homeStates.dart';
import 'package:abs_task/features/home/cubit/homeStates.dart';
import 'package:abs_task/features/home/model/homeFirebase.dart';
import 'package:abs_task/features/notes/cubit/NoteStates.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(initStateHomeState());
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  HomeFirebase firebase = HomeFirebase();

  static HomeViewModel get(context) => BlocProvider.of(context);

  void getAllNotes() async {
    emit(getNotesloadingStateHomeState());

    firebase.getNotes(userId!).listen((querySnapshot) {
      final notesList = querySnapshot.docs.map((doc) => doc.data()).toList();


      emit(getNotessuccesStateHomeState(noteModel: notesList,));
    }, onError: (error) {
      emit(getNoteserrorStateHomeState(error: error.toString()));
    });
  }

  Future<void> addNote(NoteModel note,) async {
    emit(addNoteloadingStateHomeState());

    try {
      await firebase.addnoteToFireStore(note, userId!);

      // viewModel.addNote(note);

      getAllNotes();
      emit(addNotesuccesStateHomeState(succesM: "note add succesfully"));
    } catch (e) {
      emit(addNoteerrorStateHomeState(error: e.toString()));
    }
  }
}
