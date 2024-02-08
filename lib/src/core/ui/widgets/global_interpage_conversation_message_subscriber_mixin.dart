import 'package:ankabootmobile/src/core/presentation/blocs/global_interpage_conversation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin GlobalInterPageConversationMessageSubscriberMixin {
  abstract final GlobalInterPageConversationBloc
      globalInterPageConversationBloc;

  @protected
  void handleInterPageMessageReceived(
    BuildContext context,
    GlobalInterPageConversationMessage message,
  );

  @protected
  BlocListener onInterPageMessageReceivedListener() => BlocListener<
          GlobalInterPageConversationBloc, GlobalInterPageConversationState>(
        bloc: globalInterPageConversationBloc,
        listener: (context, state) {
          final message = state.lastMessage;
          if (message != null) {
            handleInterPageMessageReceived(
              context,
              message,
            );
          }
        },
      );
}
