import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/repositories/ams_apis_repository.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/use_cases/create_ams_api_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class CreateAMSAPIBloc extends Cubit<CreateAMSAPIState> {
  final CreateAMSAPIEntity _createAMSAPIEntity;

  CreateAMSAPIBloc(this._createAMSAPIEntity)
      : super(
          const CreateAMSAPINone(),
        );

  void createAMSAPI(CreateAMSAPIEntityDTO createAMSAPIEntityDTO) async {
    emit(const CreateAMSAPILoading());
    (await _createAMSAPIEntity(createAMSAPIEntityDTO)).fold(
      left: (failure) => emit(
        CreateAMSAPIFailed(failure: failure),
      ),
      right: (_) => emit(const CreateAMSAPISucceeded()),
    );
  }
}

sealed class CreateAMSAPIState {}

final class CreateAMSAPINone implements CreateAMSAPIState {
  const CreateAMSAPINone();
}

final class CreateAMSAPISucceeded implements CreateAMSAPIState {
  const CreateAMSAPISucceeded();
}

final class CreateAMSAPIFailed implements CreateAMSAPIState {
  final Failure failure;
  const CreateAMSAPIFailed({
    required this.failure,
  });
}

final class CreateAMSAPILoading implements CreateAMSAPIState {
  const CreateAMSAPILoading();
}
