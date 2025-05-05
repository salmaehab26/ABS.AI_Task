import 'dart:async';

import 'package:abs_task/features/home/cubit/homeStates.dart';
import 'package:abs_task/features/home/cubit/homeStates.dart';
import 'package:abs_task/features/home/model/homeFirebase.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(initStateHomeState());
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  HomeFirebase firebase = HomeFirebase();
  List<NoteModel> notesList = [];
  StreamController<List<NoteModel>> notes = StreamController.broadcast();

  Future<void> getAllNotes() async {
    emit(getNotesloadingStateHomeState());
    try {
      QuerySnapshot<NoteModel> querySnapshot =
          await firebase.getNotesCollection(userId!).get();

      notesList =
          querySnapshot.docs.map((doc) {
            return doc.data();
          }).toList();
      notes.add(notesList);
      emit(getNotessuccesStateHomeState(noteModel: notesList));
    } catch (e) {
      emit(getNoteserrorStateHomeState(error: e.toString()));
    }
  }

  Future<void> addNote(NoteModel note) async {
    emit(addNoteloadingStateHomeState());

    try {
      await firebase.addnoteToFireStore(note, userId!);
      getAllNotes();
      emit(addNotesuccesStateHomeState(succesM: "note add succesfully"));
    } catch (e) {
      emit(addNoteerrorStateHomeState(error: e.toString()));
    }
  }

  Future<void> deleteNote(String noteId) async {
    emit(getNotesloadingStateHomeState());
    try {
      await firebase.deleteNote(noteId, userId!);
      getAllNotes();
      emit(getNotesupdateStateHomeState());
    } catch (e) {
      emit(getNoteserrorStateHomeState(error: e.toString()));
    }
  }

  Future<void> updatenote(NoteModel noteId) async {
    try {
      await firebase.updatenote(noteId, userId!);
    } catch (e) {
      emit(getNoteserrorStateHomeState(error: e.toString()));
    }
  }
}
