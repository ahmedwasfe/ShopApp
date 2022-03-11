
import 'package:bmi_calculator/layout/shop_app/shop_app_layout.dart';
import 'package:bmi_calculator/modules/shop/login/shop_login_screen.dart';
import 'package:bmi_calculator/modules/shop/register/cubit/cubit.dart';
import 'package:bmi_calculator/modules/shop/register/cubit/states.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/network/local/cache_helper.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DioHelper.initShopApp();
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.register!.status!) {
              CacheHelper.saveData(
                      key: Const.KEY_USER_TOKEN,
                      value: state.register!.data!.token)
                  .then((value) => navigateAndFinish(context, ShopHomeLayout()));
              print("listener: ${state.register!.message}");
            } else {
              showToast(
                message: state.register!.message!,
                state: ToastStates.FAILED,
              );
            }
          }
        },
        builder: (context, state) {
          var registerCubit = ShopRegisterCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          "Register now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        CustomFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            lable: "Name",
                            prefix: Icons.person_outline,
                            validate: (value) {
                              if (value!.isEmpty)
                                return "PLease enter your name";
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            lable: "Phone number",
                            prefix: Icons.phone_android_outlined,
                            validate: (value) {
                              if (value!.isEmpty)
                                return "Please enter your phone number";
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            lable: "Email",
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty)
                                return "Please enter your email";
                              else if (!Helper.emailValidate().hasMatch(value))
                                return "Please enter emaill correct";
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            lable: "Password",
                            prefix: Icons.lock_open_outlined,
                            suffix: registerCubit.visiblePassIcon,
                            isPassword: registerCubit.isVisiblePassword,
                            suffixClick: () => registerCubit.visiblePassword(),
                            validate: (value) {
                              if (value!.isEmpty)
                                return "Please enter password";
                              else if (value.length < 6)
                                return "The password must be greater than 6 character";
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            lable: "Confrim password",
                            prefix: Icons.lock_open_outlined,
                            suffix: registerCubit.visiblePassIcon,
                            isPassword: registerCubit.isVisiblePassword,
                            suffixClick: () => registerCubit.visiblePassword(),
                            validate: (value) {
                              if (value!.isEmpty)
                                return "Please enter confirm password";
                              else if (value.length < 6)
                                return "The password must be greater than 6 character";
                              else if (passwordController.text != value)
                                return "The two password not match";
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => CustomButton(
                                text: "Register",
                                isUpperCase: true,
                                radius: 10.0,
                                click: () {
                                  if (formKey.currentState!.validate()) {
                                    String name = nameController.text;
                                    String phone = phoneController.text;
                                    String email = emailController.text;
                                    String password = passwordController.text;

                                    registerCubit.registerUser(
                                      name: name,
                                      phone: phone,
                                      email: email,
                                      password: password,
                                    );
                                    // print(
                                    //     "${name}: ${phone}: ${email}: ${password}: :");
                                  }
                                }),
                            fallback: (context) => Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("I have an account"),
                            TextButton(
                                onPressed: () {
                                  navigateAndFinish(context, ShopLoginScreen());
                                },
                                child: Text("Login")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
