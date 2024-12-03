import 'package:firebase_test/core/network/local/shared_preference.dart';
import 'package:firebase_test/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool isBack;
  final bool isLogout;

  const CustomAppBarWidget(
      {super.key, this.title, this.isBack = false, this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      backgroundColor: Colors.brown,
      title: Text(
        title ?? "",
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      leading: isBack
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ))
          : const SizedBox(),
      actions: [
        isLogout
            ? IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false);
                  SharedPreferenceHelper.removeData(key: "uidUser");
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
            : const SizedBox()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
