import 'package:abs_task/features/notes/model/NoteModel.dart';

abstract class HomeStates{}
class initStateHomeState extends HomeStates{
}
class addNoteloadingStateHomeState extends HomeStates{}
class addNoteupdateStateHomeState extends HomeStates{}
class addNoteerrorStateHomeState extends HomeStates{
  String error;
  addNoteerrorStateHomeState({required this.error});
}

class addNotesuccesStateHomeState extends HomeStates{
String succesM;
  addNotesuccesStateHomeState({required this.succesM});}













class getNotesinitStateHomeState extends HomeStates{
}

class getNotesloadingStateHomeState extends HomeStates{}
class getNoteserrorStateHomeState extends HomeStates{
  String error;
  getNoteserrorStateHomeState({required this.error});
}

class getNotessuccesStateHomeState extends HomeStates{
  List<NoteModel> noteModel;

  getNotessuccesStateHomeState({required this.noteModel});}