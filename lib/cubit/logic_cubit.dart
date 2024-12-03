import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/core/network/global/dio_helper.dart';
import 'package:firebase_test/core/network/local/shared_preference.dart';
import 'package:firebase_test/models/message_model.dart';
import 'package:firebase_test/models/notification_model.dart';
import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/screens/chats/chats_screen.dart';
import 'package:firebase_test/screens/home_screen.dart';
import 'package:firebase_test/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logic_state.dart';

class LogicCubit extends Cubit<LogicState> {
  LogicCubit() : super(LogicInitial());

  static LogicCubit get(context) => BlocProvider.of(context);

  var formKeyLogin = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginByFirebase(context) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      SharedPreferenceHelper.saveData(key: "uidUser", value: value.user!.uid);

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginFailedState());
    });
  }

  TextEditingController forgetPasswordController = TextEditingController();
  var formKeyForgetPassword = GlobalKey<FormState>();

  void forgetPasswordFirebase(context) {
    emit(ForgetPasswordLoadingState());
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: forgetPasswordController.text)
        .then((value) {
      emit(ForgetPasswordSuccessState());
    }).catchError((error) {
      emit(ForgetPasswordFailedState());
    });
  }

  var formKeyRegister = GlobalKey<FormState>();
  TextEditingController nameControllerRegister = TextEditingController();
  TextEditingController phoneControllerRegister = TextEditingController();
  TextEditingController emailControllerRegister = TextEditingController();
  TextEditingController passwordControllerRegister = TextEditingController();
  void registerByFirebase(context) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailControllerRegister.text,
            password: passwordControllerRegister.text)
        .then((value) {
      setUser(value.user!.uid);
      SharedPreferenceHelper.saveData(key: "uidUser", value: value.user!.uid);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterFailedState());
    });
  }

  void setUser(String docId) async {
    UserModel userModel = UserModel(
      tokeNotfication: SharedPreferenceHelper.getData(key: "tokeNotfication"),
      docId: docId,
      phone: phoneControllerRegister.text,
      name: nameControllerRegister.text,
      email: emailControllerRegister.text,
    );
    await FirebaseFirestore.instance
        .collection("users")
        .doc(docId)
        .set(userModel.toJson())
        .then((value) {
      emit(SetUserInFireStoreSuccessState());
    }).catchError((error) {
      emit(SetUserInFireStoreFailedState());
    });
  }

  TextEditingController nameControllerUpdate = TextEditingController();
  TextEditingController phoneControllerUpdate = TextEditingController();
  TextEditingController emailControllerUpdate = TextEditingController();
  void updateUser() async {
    UserModel userModel = UserModel(
        name: nameControllerUpdate.text,
        phone: phoneControllerUpdate.text,
        tokeNotfication: SharedPreferenceHelper.getData(key: "tokeNotfication"),
        email: emailControllerUpdate.text,
        docId: SharedPreferenceHelper.getData(key: "uidUser"));
    emit(UpdateLoadingState());
    await FirebaseFirestore.instance
        .collection("users")
        .doc(SharedPreferenceHelper.getData(key: "uidUser"))
        .update(userModel.toJson())
        .then((value) {
      getData();
      emit(UpdateSuccessState());
    }).catchError((error) {
      emit(UpdateFailedState());
    });
  }

  UserModel? userModel;
  void getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(SharedPreferenceHelper.getData(key: "uidUser"))
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data() as Map<String, dynamic>);
      nameControllerUpdate.text = userModel!.name!;
      phoneControllerUpdate.text = userModel!.phone!;
      emailControllerUpdate.text = userModel!.email!;
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserFailedState());
    });
  }

  List<UserModel>? listUserModel;
  void getAllUsers() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where('docId',
            isNotEqualTo: SharedPreferenceHelper.getData(key: "uidUser"))
        .get()
        .then((value) {
      listUserModel =
          value.docs.map((value) => UserModel.fromJson(value.data())).toList();
      emit(GetAllUserSuccessState());
    }).catchError((error) {
      emit(GetAllUserFailedState());
    });
  }

  int currentIndex = 0;
  void chageBottomNavBar(int index) {
    currentIndex = index;
    emit(ChageBottomNavBarState());
  }

  List<Widget> screens = const [
    ChatsScreen(),
    ProfileScreen(),
  ];

  TextEditingController messageController = TextEditingController();
  void sendMessage(reciverId, token) async {
    MessageModel messageModel = MessageModel(
        SharedPreferenceHelper.getData(key: "uidUser"),
        reciverId,
        messageController.text,
        DateTime.now().toString());
    await FirebaseFirestore.instance
        .collection("users")
        .doc(SharedPreferenceHelper.getData(key: "uidUser"))
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .doc()
        .set(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageFailedState());
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(reciverId)
        .collection("chats")
        .doc(SharedPreferenceHelper.getData(key: "uidUser"))
        .collection("messages")
        .doc()
        .set(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageFailedState());
    });

    print(userModel?.name);
    messageController.clear();
  }

  List<MessageModel> listMessageModel = [];
  void getMessages(reciverId) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(SharedPreferenceHelper.getData(key: "uidUser"))
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .orderBy("date")
        .snapshots()
        .listen((event) {
      listMessageModel = event.docs
          .map((element) => MessageModel.formJson(element.data()))
          .toList();
      print(listMessageModel.toList().length);
      emit(SendMessageSuccessState());
    });
  }

  sendNotficatiion(String token, String message) async {
    NotificationModel notificationModel = NotificationModel(
        message: Message(
            token: token,
            notification:
                NotificationItem(title: "Notidcations", body: message)));
    await DioHelper.postData(
        endpoint:
            "https://fcm.googleapis.com/v1/projects/fir-test-33040/messages:send",
        data: notificationModel.toJson());
  }
}
