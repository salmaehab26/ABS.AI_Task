import 'package:abs_task/features/notes/model/NoteModel.dart';

abstract class NoteStates{}
class initNoteState extends NoteStates{
}
class deleteloadingNoteState extends NoteStates{}
class deleteerrorNoteState extends NoteStates{
  String error;
  deleteerrorNoteState({required this.error});
}
class deletesuccesNoteState extends NoteStates{

}class updateloadingNoteState extends NoteStates{}
class updateerrorNoteState extends NoteStates{
  String error;
  updateerrorNoteState({required this.error});
}
class updatesuccesNoteState extends NoteStates{

}