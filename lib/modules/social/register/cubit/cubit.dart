import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/modules/social/register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitState());

  bool isVisiblePassword = true;
  IconData visiblePassIcon = Icons.visibility_outlined;

  User? register;

  static SocialRegisterCubit getCubit(context) => BlocProvider.of(context);

  void visiblePassword() {
    isVisiblePassword = !isVisiblePassword;
    visiblePassIcon = isVisiblePassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialVisiblePasswordState());
  }

  void registerUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
    .then((value) {
      print("User UID: ${value.user!.uid}");
      print("User Email: ${value.user!.email}");
      value.user!.sendEmailVerification();
      emit(SocialRegisterSuccessState());
    })
    .catchError((error) {
      print("catchError: ${error.toString()}");
      emit(SocialRegisterFailedState(error.toString()));
    });
  }
}
