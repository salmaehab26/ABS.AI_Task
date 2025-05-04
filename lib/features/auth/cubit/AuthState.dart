
import 'package:abs_task/features/auth/model/user.dart';

abstract class UserStates{}
class initStateUserState extends UserStates{
}
class loadingStateUserState extends UserStates{}
class errorStateUserState extends UserStates{
  String error;
  errorStateUserState({required this.error});
}
class succesStateUserState extends UserStates{}