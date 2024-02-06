import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class HomePageAMSAPIFilterBloc extends Cubit<HomePageAMSAPIFilterState> {
  HomePageAMSAPIFilterBloc()
      : super(
          const HomePageAMSAPIFilterState(
            selectedStatus: null,
          ),
        );

  void selectStatus(AMSAPIStatus status) => emit(
        HomePageAMSAPIFilterState(
          selectedStatus: status == state.selectedStatus ? null : status,
        ),
      );
}

final class HomePageAMSAPIFilterState {
  final AMSAPIStatus? selectedStatus;

  const HomePageAMSAPIFilterState({
    required this.selectedStatus,
  });
}
