import 'package:firebase_test/core/base_widget/custom_app_bar_widget.dart';
import 'package:firebase_test/core/base_widget/custom_button_widget.dart';
import 'package:firebase_test/core/base_widget/custom_text_form_filed.dart';
import 'package:firebase_test/core/helper/spacing.dart';
import 'package:firebase_test/cubit/logic_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicCubit(),
      child: BlocBuilder<LogicCubit, LogicState>(
        builder: (context, state) {
          var cubit = LogicCubit.get(context);
          return Scaffold(
            appBar: const CustomAppBarWidget(
              title: "Forget Password",
              isBack: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: cubit.formKeyForgetPassword,
                child: Column(
                  children: [
                    verticleSpace(10),
                    CustomTextFormFiled(
                      prefixIcon: const Icon(Icons.email_outlined),
                      controller: cubit.forgetPasswordController,
                      hintText: "Email",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This Filed is Required";
                        }
                      },
                    ),
                    verticleSpace(40),
                    CustomButtonWidget(
                      loading: state is ForgetPasswordLoadingState,
                      text: 'Forget Password',
                      function: () {
                        if (cubit.formKeyForgetPassword.currentState!
                            .validate()) {}
                        cubit.forgetPasswordFirebase(context);
                      },
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
