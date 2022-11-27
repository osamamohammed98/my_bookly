// ignore_for_file: must_be_immutable

import 'package:bloc_basic/cubit/chat/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bloc_basic/constants.dart';
import 'package:bloc_basic/widgets/chat_buble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();


  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return BlocProvider(
      create: (context) => ChatCubit()..getMessages(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var chatCubit = ChatCubit.instance(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  const Text('chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: chatCubit.messagesList.length,
                      itemBuilder: (context, index) {
                        return chatCubit.messagesList[index].id == email
                            ? ChatBuble(
                          message: chatCubit.messagesList[index],
                        )
                            : ChatBubleForFriend(
                            message: chatCubit.messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) => chatCubit.sendMessage(data , controller , _controller , email),
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: InkWell(
                        onTap: ()=> chatCubit.sendMessage(controller.text , controller , _controller , email),
                        child: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
