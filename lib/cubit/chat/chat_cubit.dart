import 'package:bloc/bloc.dart';
import 'package:bloc_basic/constants.dart';
import 'package:bloc_basic/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/scroll_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit instance(context) => BlocProvider.of<ChatCubit>(context);

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  List<Message> messagesList = [];

  void sendMessage(String data, TextEditingController controller,
      ScrollController scrollController, dynamic email) {
    if (data.isNotEmpty) {
      messages.add(
        {kMessage: data, kCreatedAt: DateTime.now(), 'id': email},
      );

      controller.clear();
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        messagesList.clear();
        for (int i = 0; i < event.docs.length; i++) {
          messagesList.add(Message.fromJson(event.docs[i]));
        }
      }
      emit(ChatSuccessMessageSendState());
    });
  }
}
