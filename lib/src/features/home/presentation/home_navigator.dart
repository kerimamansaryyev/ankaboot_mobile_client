import 'package:ankabootmobile/src/core/navigation/app_navigator.dart';
import 'package:ankabootmobile/src/core/navigation/per_page_navigator_mixin.dart';
import 'package:ankabootmobile/src/di/injection_container.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/home/presentation/widgets/home_page_choose_ams_status_dialog.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

typedef HomePageChooseAMSStatusDialogOnStatusChosen = void Function(
  AMSAPIStatus status,
);

@injectable
final class HomeNavigator
    with PerPageNavigatorMixin, HomePageChooseAMSStatusDialogMixin {
  @override
  final AppNavigator appNavigator;

  const HomeNavigator({
    required this.appNavigator,
  });

  factory HomeNavigator.fromEnv() => serviceLocator<HomeNavigator>();
}

mixin HomePageChooseAMSStatusDialogMixin on PerPageNavigatorMixin {
  void showChooseAMSStatusDialog(
    BuildContext context, {
    required AMSAPIStatus? selectedStatus,
    required HomePageChooseAMSStatusDialogOnStatusChosen onStatusChosen,
  }) =>
      showDialog(
        context: context,
        builder: (context) => HomePageChooseAMASStatusDialog(
          selectedStatus: selectedStatus,
          onStatusChosen: (status) {
            appNavigator.pop(context: context);
            onStatusChosen(status);
          },
        ),
      );
}
