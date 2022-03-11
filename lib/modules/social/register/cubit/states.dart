
abstract class SocialRegisterStates {
}

class SocialRegisterInitState extends SocialRegisterStates {}

class SocialVisiblePasswordState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {
}

class SocialRegisterFailedState extends SocialRegisterStates {
  final String error;
  SocialRegisterFailedState(this.error);
}
