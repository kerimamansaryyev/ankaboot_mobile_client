import 'package:ankabootmobile/src/core/presentation/blocs/global_interpage_conversation_bloc.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:flutter/material.dart';

final class CreateAMSAPIPageAPICreatedMessage
    implements
        GlobalInterPageConversationMessage,
        GlobalInterPageConversationDisplayMessage {
  @override
  final bool displayFromRootSubscriber = true;

  const CreateAMSAPIPageAPICreatedMessage();

  @override
  void displayMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          context.translation.createAMSAPIPageAPICreated,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
