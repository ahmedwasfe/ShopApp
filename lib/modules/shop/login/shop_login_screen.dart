import 'package:bmi_calculator/layout/shop_app/shop_app_layout.dart';
import 'package:bmi_calculator/modules/shop/login/cubit/cubit.dart';
import 'package:bmi_calculator/modules/shop/login/cubit/states.dart';
import 'package:bmi_calculator/modules/shop/register/shop_register_screen.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isVisiblePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.login!.status!){

              CacheHelper.saveData(
                  key: Const.KEY_USER_TOKEN,
                  value: state.login!.data!.token)
                  .then((value) {
                CacheHelper.saveData(
                    key: Const.KEY_USER_NAME,
                    value: state.login!.data!.name)
                    .then((value) => navigateAndFinish(context, ShopHomeLayout()));
              });
              print("listener: ${state.login!.message}");
              // showToast(
              //     message: '${state.login!.message}',
              //     state: ToastStates.SUCCESS);
            }else{
              showToast(
                  message: state.login!.message!,
                  state: ToastStates.FAILED);
            }
          }
        },
        builder: (context, state) {
          var loginCubit = ShopLoginCubit.getCubit(context);
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
                          "LOGIN",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        CustomFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            lable: "e-mail",
                            prefix: Icons.email_outlined,
                            isPassword: false,
                            validate: (email) {
                              if (email!.isEmpty)
                                return "Please enter email address";
                              else if (!Helper.emailValidate().hasMatch(email))
                                return "Please enter emaill correct";
                              return null;
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            lable: "password",
                            prefix: Icons.lock_open_outlined,
                            suffix: loginCubit.visiblePassIcon,
                            isPassword: loginCubit.isVisiblePassword,
                            suffixClick: () => loginCubit.visiblePassword(),
                            validate: (password) {
                              if (password!.isEmpty) {
                                return "Please enter password";
                              } else if (password.length < 6)
                                return "The password must be greater than 6 character";
                              return null;
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                String email = emailController.text;
                                String password = passwordController.text;
                                loginCubit.loginUser(
                                    email: email, password: password);
                              }
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (_) => CustomButton(
                              text: "login",
                              isUpperCase: true,
                              radius: 10.0,
                              click: () {
                                if (formKey.currentState!.validate()) {
                                  String email = emailController.text;
                                  String password = passwordController.text;
                                  loginCubit.loginUser(
                                      email: email, password: password);
                                }
                              }),
                          fallback: (_) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account?"),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                child: Text("Register now")),
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
