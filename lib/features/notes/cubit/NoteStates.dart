import 'package:abs_task/features/notes/model/NoteModel.dart';

abstract class NoteStates{}
class initStateNoteState extends NoteStates{
}
class loadingStateNoteState extends NoteStates{}
class errorStateNoteState extends NoteStates{
String error;
errorStateNoteState({required this.error});
}
class succesStateNoteState extends NoteStates{
List<NoteModel> noteModel;
succesStateNoteState({required this.noteModel});}