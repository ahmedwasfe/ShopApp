import 'package:bmi_calculator/modules/social/login/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitState());

  bool isPasswordVisible = true;
  IconData passwordVisibleIcon = Icons.visibility_outlined;

  static SocialLoginCubit getCubit(BuildContext context) =>
      BlocProvider.of(context);

  void visiblePassword() {
    isPasswordVisible = !isPasswordVisible;
    passwordVisibleIcon = isPasswordVisible
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialVisiblePasswordState());
  }
}
