import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:ankabootmobile/src/core/utils/failure_mapper.dart';
import 'package:ankabootmobile/src/core/utils/mvp/app_presenter.dart';
import 'package:ankabootmobile/src/di/injection_container.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/blocs/create_ams_api_bloc.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page_model.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class CreateAMSAPIPagePresenter
    extends AppPresenter<CreateAMSAPIPageView, CreateAMSAPIPageModel> {
  @override
  @protected
  final CreateAMSAPIPageModel model;

  CreateAMSAPIPagePresenter(
    this.model,
  );

  factory CreateAMSAPIPagePresenter.fromEnv() =>
      serviceLocator<CreateAMSAPIPagePresenter>();

  void createAMSAPI({
    required String title,
    required String description,
    required String url,
    required AMSAPIStatus status,
  }) =>
      model.createAMSAPIBloc.createAMSAPI(
        (
          title: title,
          description: description,
          url: url,
          status: status,
        ),
      );

  BlocBase<CreateAMSAPIState> createAMSAPIBloc() => model.createAMSAPIBloc;

  @override
  void dispose() {
    model.createAMSAPIBloc.close();
    super.dispose();
  }

  @override
  Widget buildMultiBlocListener(
    BuildContext context,
    Widget child, {
    Key? key,
  }) {
    return MultiBlocListener(
      listeners: [_onAPICreateChanged()],
      child: child,
    );
  }

  BlocListener _onAPICreateChanged() =>
      BlocListener<CreateAMSAPIBloc, CreateAMSAPIState>(
        bloc: model.createAMSAPIBloc,
        listener: (context, state) => switch (state) {
          CreateAMSAPINone() || CreateAMSAPILoading() => null,
          CreateAMSAPISucceeded() => () {
              view?.showSuccessDialog(
                context,
                context.translation.createAMSAPIPageAPICreated,
              );
              view?.popScreen();
            }(),
          CreateAMSAPIFailed(failure: final failure) => view?.showErrorDialog(
              context,
              failure.mapToStringWith(context),
            ),
        },
      );
}
