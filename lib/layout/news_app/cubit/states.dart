
abstract class NewsStates {}

class NewsInitState extends NewsStates {}

class BottomNavState extends NewsStates {}

class NewsBussinesLoadingState extends NewsStates {}

class NewsBussinesSuccessState extends NewsStates {}

class NewsBussinesFailedState extends NewsStates {
  final String error;

  NewsBussinesFailedState(this.error);
}

class NewsSportLoadingState extends NewsStates {}

class NewsSportSuccessState extends NewsStates {}

class NewsSportFailedState extends NewsStates {
  final String error;

  NewsSportFailedState(this.error);
}

class NewsScienceLoadingState extends NewsStates {}

class NewsScienceSuccessState extends NewsStates {}

class NewsScienceFailedState extends NewsStates {
  final String error;

  NewsScienceFailedState(this.error);
}

class NewsSearchLoadingState extends NewsStates {}

class NewsSearchSuccessState extends NewsStates {}

class NewsSearchFailedState extends NewsStates {
  final String error;

  NewsSearchFailedState(this.error);
}