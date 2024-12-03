import 'package:firebase_test/core/base_widget/custom_app_bar_widget.dart';
import 'package:firebase_test/core/base_widget/custom_button_widget.dart';
import 'package:firebase_test/core/base_widget/custom_text_form_filed.dart';
import 'package:firebase_test/core/helper/spacing.dart';
import 'package:firebase_test/cubit/logic_cubit.dart';
import 'package:firebase_test/screens/auth/forget_password_screen.dart';
import 'package:firebase_test/screens/auth/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicCubit(),
      child: BlocBuilder<LogicCubit, LogicState>(
        builder: (context, state) {
          var cubit = LogicCubit.get(context);
          return Scaffold(
            appBar: const CustomAppBarWidget(
              title: "Logn In",
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: cubit.formKeyLogin,
                child: Column(
                  children: [
                    verticleSpace(10),
                    CustomTextFormFiled(
                      prefixIcon: const Icon(Icons.email_outlined),
                      controller: cubit.emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This Filed is Required";
                        }
                      },
                    ),
                    verticleSpace(10),
                    CustomTextFormFiled(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      controller: cubit.passwordController,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility_off_rounded)),
                      hintText: "Password",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This Filed is Required";
                        }
                      },
                    ),
                    verticleSpace(10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ForgetPasswordScreen()));
                      },
                      child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forget Password ?",
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    verticleSpace(40),
                    CustomButtonWidget(
                      loading: state is LoginLoadingState,
                      text: 'Logn In',
                      function: () {
                        if (cubit.formKeyLogin.currentState!.validate()) {}
                        cubit.loginByFirebase(context);
                      },
                    ),
                    verticleSpace(20),
                    Align(
                      // alignment: Alignment.centerRight,
                      child: Text.rich(TextSpan(
                          text: 'Dont Have Account? ',
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: "Click Here",
                                style: const TextStyle(
                                    color: Colors.brown,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => RegisterScreen()));
                                  }),
                          ])),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
