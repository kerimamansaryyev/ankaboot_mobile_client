import 'package:ankabootmobile/src/core/utils/mvp/app_model.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/blocs/create_ams_api_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class CreateAMSAPIPageModel implements AppModel {
  final CreateAMSAPIBloc createAMSAPIBloc;

  const CreateAMSAPIPageModel(
    this.createAMSAPIBloc,
  );
}
