
abstract class UserStates {
}

class initStateUserState extends UserStates {}

class loadingStateUserState extends UserStates {}

class succesStateUserState extends UserStates {}

class errorStateUserState extends UserStates {
  final String error;

  errorStateUserState(this.error);
}
