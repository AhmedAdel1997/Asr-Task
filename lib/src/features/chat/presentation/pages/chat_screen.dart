import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/res/constants_manager.dart';
import '../cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_body.dart/chat_body.dart';
import '../widgets/send_message_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<GetChatMessagesCubit>()..getChatMessagesStream(chatId: '1'),
      child: const Scaffold(
        appBar: ChatAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SendMessageWidget(),
        body: ChatBody(),
      ),
    );
  }
}
