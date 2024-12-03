import 'package:firebase_test/core/helper/spacing.dart';
import 'package:firebase_test/cubit/logic_cubit.dart';
import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/screens/chats/messages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicCubit()..getAllUsers(),
      child: BlocBuilder<LogicCubit, LogicState>(
        builder: (context, state) {
          var cubit = LogicCubit.get(context);
          return cubit.listUserModel == null
              ? const Center(child: CircularProgressIndicator())
              : cubit.listUserModel!.isEmpty
                  ? const Center(
                      child: Text(
                        "There are no conversations",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) =>
                          profileChat(cubit.listUserModel![index], context),
                      separatorBuilder: (context, index) => verticleSpace(10),
                      itemCount: cubit.listUserModel!.length);
        },
      ),
    );
  }
}

Widget profileChat(UserModel userModel, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MessagesScreen(
                    userModel: userModel,
                  )));
    },
    child: ListTile(
      leading: Image.network(
        "https://tse1.mm.bing.net/th?id=OIP.IGNf7GuQaCqz_RPq5wCkPgHaLH&pid=Api",
      ),
      title: Text(userModel.name ?? ""),
      subtitle: Text(userModel.email ?? ""),
    ),
  );
}
