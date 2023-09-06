abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserGetUserLoadingState extends UserStates {}

class UserLoginSuccessfulState extends UserStates {}

class UserLoginErrorState extends UserStates {}

class UserRegistrationSuccessfulState extends UserStates {}

class UserRegistrationErrorState extends UserStates {}

class UserCreateUserSuccessfulState extends UserStates {
  final String uId;

  UserCreateUserSuccessfulState(this.uId);
}

class UserCreateUserErrorState extends UserStates {}

class UserGetUserSuccessfulState extends UserStates {}

class UserGetUserErrorState extends UserStates {}

class UserHidePasswordState extends UserStates {}