import 'package:bmi_calculator/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isVisiblePassword = true;
  IconData suffixIcon = Icons.remove_red_eye_rounded;
  var formKey = GlobalKey<FormState>();
  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    prefix: Icons.phone,
                    lable: "Phone number",
                    validate: (phone) {
                      if (phone!.isEmpty)
                        return "Phone number is required";
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  CustomFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    lable: "Enter email address",
                    prefix: Icons.email,
                    isPassword: false,
                    validate: (email) {
                      if (email!.isEmpty)
                        return "Please enter email";
                      else if (!emailValid.hasMatch(email))
                        return "Please enter emaill correct";
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      lable: "Enter password",
                      prefix: Icons.lock,
                      suffix: isVisiblePassword ? Icons.visibility : Icons.visibility_off,
                      isPassword: isVisiblePassword,
                      suffixClick: () {
                        setState(() {
                          isVisiblePassword = !isVisiblePassword;
                          // if(isVisiblePassword) {
                          //   isVisiblePassword = false;
                          //   suffixIcon = Icons.visibility_off_rounded;
                          // }else {
                          //   isVisiblePassword = true;
                          //   suffixIcon = Icons.remove_red_eye_rounded;
                          // }
                          print(isVisiblePassword);
                        });
                      },
                      validate: (password) {
                        if (password!.isEmpty) {
                          return "Please enter password";
                        } else if (password.length < 6)
                          return "The password must be greater than 6 character";
                        return null;
                      }),
                  SizedBox(height: 20),
                  CustomButton(
                    width: double.infinity,
                    background: Colors.blueAccent,
                    text: "login",
                    radius: 50.0,
                    click: () {
                      if (formKey.currentState!.validate()) {
                        print("Phone: ${phoneController.text}"+
                            " Email: ${emailController.text}"+
                            "  Password: ${passwordController.text}");
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    width: 200.0,
                    background: Colors.redAccent,
                    text: "RegISter",
                    isUpperCase: true,
                    marginLeft: 60.0,
                    radius: 50.0,
                    click: () {},
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have an account?"),
                      TextButton(onPressed: () {}, child: Text("Register now"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
