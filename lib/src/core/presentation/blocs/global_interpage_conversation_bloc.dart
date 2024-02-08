import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class GlobalInterPageConversationBloc
    extends Cubit<GlobalInterPageConversationState> {
  GlobalInterPageConversationBloc()
      : super(
          const GlobalInterPageConversationState(
            lastMessage: null,
          ),
        );

  void publishMessage(GlobalInterPageConversationMessage message) => emit(
        GlobalInterPageConversationState(
          lastMessage: message,
        ),
      );
}

final class GlobalInterPageConversationState {
  final GlobalInterPageConversationMessage? lastMessage;

  const GlobalInterPageConversationState({
    required this.lastMessage,
  });
}

abstract interface class GlobalInterPageConversationMessage {}

abstract interface class GlobalInterPageConversationDisplayMessage
    implements GlobalInterPageConversationMessage {
  bool get displayFromRootSubscriber;

  void displayMessage(
    BuildContext context,
  );
}
