import 'package:abs_task/features/notes/model/NoteModel.dart';

abstract class HomeStates{}
class initStateHomeState extends HomeStates{
}
class loadingStateHomeState extends HomeStates{}
class errorStateHomeState extends HomeStates{

}
class succesStateHomeState extends HomeStates{
NoteModel noteModel;
succesStateHomeState({required this.noteModel});}