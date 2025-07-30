import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/res/constants_manager.dart';
import '../cubit/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_body.dart/chat_body.dart';
import '../widgets/send_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure no focus when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<GetChatMessagesCubit>()..getChatMessagesStream(chatId: '1'),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const ChatAppBar(),
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const SendMessageWidget(),
          ),
          body: const ChatBody(),
        ),
      ),
    );
  }
}
