abstract class SocialLoginStates {}

class SocialLoginInitState extends SocialLoginStates {}

class SocialVisiblePasswordState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {}

class SocialLoginFailedState extends SocialLoginStates {
  final String error;

  SocialLoginFailedState(this.error);
}