import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/service_management_system/domain/entities/sms_service_entity.dart';
import 'package:ankabootmobile/src/features/service_management_system/domain/use_cases/get_sms_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class FetchSMSServicesBloc extends Cubit<FetchSMSServicesState> {
  final GetSMSServices _getSMSServices;

  FetchSMSServicesBloc(
    this._getSMSServices,
  ) : super(
          const FetchSMSServicesLoading(),
        );

  void fetchServices() async {
    emit(const FetchSMSServicesLoading());
    final newState = (await _getSMSServices()).fold(
      left: (failure) => FetchSMSServicesError(
        failure: failure,
      ),
      right: (services) => services.isEmpty
          ? const FetchSMSServicesEmpty()
          : FetchSMSServicesSucceeded(
              serviceEntities: services,
            ),
    );
    if (!isClosed) {
      emit(newState);
    }
  }
}

sealed class FetchSMSServicesState {}

final class FetchSMSServicesLoading implements FetchSMSServicesState {
  const FetchSMSServicesLoading();
}

final class FetchSMSServicesEmpty implements FetchSMSServicesState {
  const FetchSMSServicesEmpty();
}

final class FetchSMSServicesError implements FetchSMSServicesState {
  final Failure failure;

  const FetchSMSServicesError({
    required this.failure,
  });
}

final class FetchSMSServicesSucceeded implements FetchSMSServicesState {
  final List<SMSServiceEntity> serviceEntities;

  const FetchSMSServicesSucceeded({
    required this.serviceEntities,
  });
}
