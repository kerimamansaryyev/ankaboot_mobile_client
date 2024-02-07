import 'package:ankabootmobile/src/core/navigation/app_navigator.dart';
import 'package:ankabootmobile/src/core/navigation/per_page_navigator_mixin.dart';
import 'package:ankabootmobile/src/di/injection_container.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page.dart';
import 'package:ankabootmobile/src/features/home/presentation/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
final class AMSAPIsNavigator
    with PerPageNavigatorMixin, HomePageChooseAMSStatusDialogMixin {
  @override
  final AppNavigator appNavigator;

  const AMSAPIsNavigator(
    this.appNavigator,
  );
  factory AMSAPIsNavigator.fromEnv() => serviceLocator<AMSAPIsNavigator>();
}

mixin CreateAMSAPIPageRouteMixin on PerPageNavigatorMixin {
  void navigateToCreateAMSAPIPage(BuildContext context) => appNavigator.push(
        MaterialPageRoute(
          builder: (context) => const CreateAMSAPIPage(),
        ),
        context: context,
      );
}
