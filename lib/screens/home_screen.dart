import 'package:firebase_test/core/base_widget/custom_app_bar_widget.dart';

import 'package:firebase_test/cubit/logic_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicCubit()..getAllUsers(),
      child: BlocBuilder<LogicCubit, LogicState>(
        builder: (context, state) {
          var cubit = LogicCubit.get(context);
          return Scaffold(
            appBar: const CustomAppBarWidget(
              title: "Home Screen",
              isLogout: true,
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (value) {
                  cubit.chageBottomNavBar(value);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_outlined), label: "Chats"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_pin_outlined), label: "Profile"),
                ]),
          );
        },
      ),
    );
  }
}
