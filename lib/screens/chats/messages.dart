import 'package:firebase_test/core/base_widget/custom_app_bar_widget.dart';
import 'package:firebase_test/core/base_widget/custom_text_form_filed.dart';
import 'package:firebase_test/core/network/local/shared_preference.dart';
import 'package:firebase_test/cubit/logic_cubit.dart';
import 'package:firebase_test/models/message_model.dart';
import 'package:firebase_test/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatelessWidget {
  final UserModel userModel;

  const MessagesScreen({super.key, required this.userModel});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicCubit()..getMessages(userModel.docId),
      child: BlocBuilder<LogicCubit, LogicState>(
        builder: (context, state) {
          var cubit = LogicCubit.get(context);
          return Scaffold(
            appBar: const CustomAppBarWidget(
              title: "Messages Screen",
              isBack: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 15),
                      itemBuilder: (context, index) =>
                          buildMessageItem(cubit.listMessageModel[index]),
                      itemCount: cubit.listMessageModel.length),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormFiled(
                      prefixIcon: const Icon(
                        Icons.message_outlined,
                        color: Colors.brown,
                      ),
                      controller: cubit.messageController,
                      hintText: "Write Message...",
                      suffixIcon: IconButton(
                          onPressed: () {
                            cubit.sendMessage(
                                userModel.docId, userModel.tokeNotfication);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.brown,
                          )),
                      validator: (value) {}),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget buildMessageItem(MessageModel messageModel) {
  return Align(
    alignment:
        messageModel.senderId == SharedPreferenceHelper.getData(key: "uidUser")
            ? AlignmentDirectional.centerStart
            : AlignmentDirectional.centerEnd,
    child: Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: messageModel.senderId ==
                  SharedPreferenceHelper.getData(key: "uidUser")
              ? Colors.brown
              : Colors.grey),
      child: Text(
        messageModel.message ?? "",
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    ),
  );
}
