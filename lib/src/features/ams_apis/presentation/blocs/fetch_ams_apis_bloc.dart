import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_entity.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/use_cases/get_ams_api_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class FetchAMSAPIsBloc extends Cubit<FetchAMSAPIsState> {
  final GetAMSAPIEntities _getAMSAPIEntities;

  FetchAMSAPIsBloc(
    this._getAMSAPIEntities,
  ) : super(
          const FetchAMSAPIsLoading(),
        );

  void fetchApis({
    AMSAPIStatus? statusFilter,
  }) async {
    emit(const FetchAMSAPIsLoading());
    emit(
      (await _getAMSAPIEntities(
        statusFilter: statusFilter,
      ))
          .fold(
        left: (failure) => FetchAMSAPIsError(
          failure: failure,
        ),
        right: (amsAPIs) => amsAPIs.isEmpty
            ? const FetchAMSAPIsEmpty()
            : FetchAMSAPIsSucceeded(
                apiEntities: amsAPIs,
              ),
      ),
    );
  }
}

sealed class FetchAMSAPIsState {}

final class FetchAMSAPIsLoading implements FetchAMSAPIsState {
  const FetchAMSAPIsLoading();
}

final class FetchAMSAPIsEmpty implements FetchAMSAPIsState {
  const FetchAMSAPIsEmpty();
}

final class FetchAMSAPIsError implements FetchAMSAPIsState {
  final Failure failure;

  const FetchAMSAPIsError({
    required this.failure,
  });
}

final class FetchAMSAPIsSucceeded implements FetchAMSAPIsState {
  final List<AMSAPIEntity> apiEntities;

  const FetchAMSAPIsSucceeded({
    required this.apiEntities,
  });
}
