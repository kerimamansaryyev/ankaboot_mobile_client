import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_entity.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/use_cases/change_status_ams_api_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

typedef GlobalAMSAPIStatusChangeStoreAMSAPIEntityDTO = ({
  String id,
  AMSAPIStatus status,
});

@lazySingleton
final class GlobalAMSAPIStatusChangeStore
    extends Cubit<GlobalAMSAPIStatusChangeState> {
  final ChangeStatusAMSAPIEntity _changeStatusAMSAPIEntity;
  final Map<String, GlobalAMSAPIStatusChangeStateItem> _internal = {};
  GlobalAMSAPIStatusChangeStateItem? _internalLatest;

  GlobalAMSAPIStatusChangeStore(
    this._changeStatusAMSAPIEntity,
  ) : super(
          GlobalAMSAPIStatusChangeState(
            items: const {},
            latest: null,
          ),
        );

  void changeStatus({
    required GlobalAMSAPIStatusChangeStoreAMSAPIEntityDTO apiEntity,
    required AMSAPIStatus newStatus,
  }) async {
    _internalLatest =
        _internal[apiEntity.id] = GlobalAMSAPIStatusChangeStateItemLoading(
      currentStatus: _internal[apiEntity.id]?.currentStatus ?? apiEntity.status,
    );
    _emit();
    (await _changeStatusAMSAPIEntity(
      (
        apiID: apiEntity.id,
        newStatus: newStatus,
      ),
    ))
        .fold(
      left: (failure) => _emitWithFailure(
        apiEntity: apiEntity,
        failure: failure,
      ),
      right: (_) => _emitWithSuccess(
        apiEntity: apiEntity,
        newStatus: newStatus,
      ),
    );
  }

  void clearSucceededOnesWith({
    required List<GlobalAMSAPIStatusChangeStoreAMSAPIEntityDTO> snippets,
  }) {
    for (final snippet in snippets) {
      final stateItem = _internal[snippet.id];
      if (stateItem is GlobalAMSAPIStatusChangeStateItemLoading) {
        continue;
      }
      _internal[snippet.id] = GlobalAMSAPIStatusChangeStateItemSucceeded(
        currentStatus: snippet.status,
      );
    }
    _emit();
  }

  void _emitWithSuccess({
    required GlobalAMSAPIStatusChangeStoreAMSAPIEntityDTO apiEntity,
    required AMSAPIStatus newStatus,
  }) {
    _internalLatest =
        _internal[apiEntity.id] = GlobalAMSAPIStatusChangeStateItemSucceeded(
      currentStatus: newStatus,
    );
    _emit();
  }

  void _emitWithFailure({
    required GlobalAMSAPIStatusChangeStoreAMSAPIEntityDTO apiEntity,
    required Failure failure,
  }) {
    _internalLatest =
        _internal[apiEntity.id] = GlobalAMSAPIStatusChangeStateItemError(
      currentStatus: _internal[apiEntity.id]?.currentStatus ?? apiEntity.status,
      failure: failure,
    );
    _emit();
  }

  void _emit() {
    emit(
      GlobalAMSAPIStatusChangeState(
        items: _internal,
        latest: _internalLatest,
      ),
    );
    _internalLatest = null;
  }
}

extension GlobalAMSAPIStatusChangeStoreTransformExtension on AMSAPIEntity {
  AMSAPIEntity transformWithRecordedStatus(
    GlobalAMSAPIStatusChangeState state,
  ) =>
      AMSAPIEntity(
        id: id,
        title: title,
        status: state.items[id]?.currentStatus ?? status,
        url: url,
        description: description,
      );
}

final class GlobalAMSAPIStatusChangeState {
  final Map<String, GlobalAMSAPIStatusChangeStateItem> items;
  final GlobalAMSAPIStatusChangeStateItem? latest;

  GlobalAMSAPIStatusChangeState({
    required this.items,
    required this.latest,
  });
}

sealed class GlobalAMSAPIStatusChangeStateItem {
  AMSAPIStatus get currentStatus;
}

final class GlobalAMSAPIStatusChangeStateItemLoading
    implements GlobalAMSAPIStatusChangeStateItem {
  @override
  final AMSAPIStatus currentStatus;
  const GlobalAMSAPIStatusChangeStateItemLoading({
    required this.currentStatus,
  });
}

final class GlobalAMSAPIStatusChangeStateItemSucceeded
    implements GlobalAMSAPIStatusChangeStateItem {
  @override
  final AMSAPIStatus currentStatus;
  const GlobalAMSAPIStatusChangeStateItemSucceeded({
    required this.currentStatus,
  });
}

final class GlobalAMSAPIStatusChangeStateItemError
    implements GlobalAMSAPIStatusChangeStateItem {
  final Failure failure;
  @override
  final AMSAPIStatus currentStatus;

  const GlobalAMSAPIStatusChangeStateItemError({
    required this.currentStatus,
    required this.failure,
  });
}
