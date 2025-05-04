import 'package:abs_task/features/home/model/homeFirebase.dart';
import 'package:abs_task/features/notes/cubit/NoteStates.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class homeViewModel extends Cubit<NoteStates> {
  homeViewModel() : super(initStateNoteState());
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  void getAllNotes() {
    emit(loadingStateNoteState());

    NotesFirebase.getNotes(userId!).listen(
      (QuerySnapshot<NoteModel> snapshot) {
        List<NoteModel> noteList = snapshot.docs.map((e) => e.data()).toList();
        emit(succesStateNoteState(noteModel: noteList));
      },
      onError: (error) {
        emit(errorStateNoteState(error: error.toString()));
      },
    );
  }

  Future<void> addNote(NoteModel note) async {
    try {
      await NotesFirebase.addnoteToFireStore(note,userId!);
      print('Task added successfully');
    } catch (e) {
      print('Error adding task: $e');
    }
  }
  Future<void> deleteNote(String noteId) async {
    try {
      await NotesFirebase.deleteNote(noteId,userId!);
      getAllNotes();
    } catch (e) {
      emit(errorStateNoteState(error: e.toString()));
    }
  }Future<void> updatenote(NoteModel noteId) async {
    try {
      await NotesFirebase.updatenote(noteId,userId!);
    } catch (e) {
      emit(errorStateNoteState(error: e.toString()));
    }
  }
}
