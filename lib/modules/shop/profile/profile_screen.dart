import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/states.dart';
import 'package:bmi_calculator/models/shop/user/user_model.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.getCubit(context);
        User user = shopCubit.user!;
        if (user != null) {
          nameController.text = user.data!.name!;
          emailController.text = user.data!.email!;
          phoneController.text = user.data!.phone!;
        }
        return ConditionalBuilder(
          condition: shopCubit.user != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is ShopLoadingState)
                  LinearProgressIndicator(),

                SizedBox(
                    height: 20.0,
                  ),
                CustomFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    lable: "Name",
                    prefix: Icons.person_outline,
                    validate: (value) {
                      if (value!.isEmpty) return "Please enter your name";
                      return null;
                    }),
                SizedBox(
                  height: 20.0,
                ),
                CustomFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    lable: "email",
                    prefix: Icons.email_outlined,
                    validate: (value) {
                      if (value!.isEmpty)
                        return "Please enter email address";
                      else if (!Helper.emailValidate().hasMatch(value))
                        return "Please enter emaill correct";
                      return null;
                    }),
                SizedBox(
                  height: 20.0,
                ),
                CustomFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    lable: "Phone number",
                    prefix: Icons.smartphone_outlined,
                    validate: (value) {
                      if (value!.isEmpty)
                        return "Please enter email address";
                      else if (!Helper.emailValidate().hasMatch(value))
                        return "Please enter emaill correct";
                      return null;
                    }),
                SizedBox(
                  height: 20.0,
                ),
                CustomButton(
                    text: "Edit Profile",
                    isUpperCase: false,
                    background: Colors.green,
                    radius: 10.0,
                    click: () {
                      String name = nameController.text;
                      String email = emailController.text;
                      String phone = phoneController.text;
                      shopCubit.updateUserProfile(
                        name: name,
                        email: email,
                        phone: phone,
                      );
                    }),
                Spacer(),
                CustomButton(
                    text: "Logout",
                    background: Colors.redAccent,
                    radius: 10.0,
                    click: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Log Out"),
                                contentPadding: EdgeInsets.all(20.0),
                                content: Text("Do you want to logout"),
                                actions: [
                                  TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () => Navigator.pop(context)),
                                  TextButton(
                                    child: Text("Logout"),
                                    onPressed: () => Helper.signOut(context),
                                  ),
                                ],
                              ));
                    })
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
