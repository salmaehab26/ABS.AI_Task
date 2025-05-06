import 'package:abs_task/features/home/model/homeFirebase.dart';
import 'package:abs_task/features/notes/cubit/NoteStates.dart';
import 'package:abs_task/features/notes/model/NoteModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteViewModel extends Cubit<NoteStates> {
  NoteViewModel() : super(initNoteState());
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  HomeFirebase firebase = HomeFirebase();
  static NoteViewModel get(context) => BlocProvider.of(context);

  Future<void> deleteNote(String noteId) async {
    emit(deleteloadingNoteState());
    try {
      await firebase.deleteNote(noteId, userId!);
      emit(deletesuccesNoteState());
    } catch (e) {
      emit(deleteerrorNoteState(error: e.toString()));
    }
  }

  Future<void> updatenote(NoteModel note) async {
    emit(updateloadingNoteState());
    try {
      await firebase.updateNote(note, userId!);
      emit(updatesuccesNoteState() );
    } catch (e) {
      emit(updateerrorNoteState(error: e.toString()));
    }
  }
}



