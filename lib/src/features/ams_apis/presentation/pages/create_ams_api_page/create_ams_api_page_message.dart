import 'package:ankabootmobile/src/core/presentation/blocs/global_interpage_conversation_bloc.dart';

final class CreateAMSAPIPageAPICreatedMessage
    implements GlobalInterPageConversationMessage {
  final String text;

  const CreateAMSAPIPageAPICreatedMessage({
    required this.text,
  });
}
