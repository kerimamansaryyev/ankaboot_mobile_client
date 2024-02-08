import 'package:ankabootmobile/src/core/utils/mvp/app_view.dart';
import 'package:flutter/cupertino.dart';

abstract interface class CreateAMSAPIPageView implements AppView {
  void showErrorDialog(BuildContext context, String message);
  void popScreen();
}
